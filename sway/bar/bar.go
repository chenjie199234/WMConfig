package main

import (
	"bufio"
	"bytes"
	"flag"
	"fmt"
	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/disk"
	"github.com/shirou/gopsutil/mem"
	"github.com/shirou/gopsutil/net"
	"github.com/tidwall/sjson"
	"io/ioutil"
	"os"
	"os/exec"
	"strconv"
	"time"
)

type netcard struct {
	name  string
	speed uint64
}

var json string
var count int
var zone = flag.Bool("z", false, "Output the time zone info")
var battery = flag.Bool("b", false, "Output the battery info")

func main() {
	flag.Parse()
	lastnetup := make(map[string]uint64)
	lastnetdown := make(map[string]uint64)

	lastdiskread := make(map[string]uint64)
	lastdiskwrite := make(map[string]uint64)

	statusprefix := []byte("status")
	durationprefix := []byte("duration")
	positionprefix := []byte("position")
	fileprefix := []byte("file")
	stopped := []byte("stopped")

	fmt.Println("{\"version\":1}")
	fmt.Println("[")
	fmt.Println("[]")
	tker := time.NewTicker(time.Second)
	for {
		<-tker.C
		json = ""
		count = 0
		//net io
		{
			tempcards, e := net.Interfaces()
			cards := make([]net.InterfaceStat, 0)
			if e == nil {
				for _, card := range tempcards {
					useful := false
					for _, flag := range card.Flags {
						if flag == "up" && len(card.Addrs) != 0 {
							useful = true
						} else if flag == "loopback" {
							useful = false
							break
						}
					}
					if useful {
						cards = append(cards, card)
					}
				}
				for n := range lastnetup {
					find := false
					for _, card := range cards {
						if card.Name == n {
							find = true
							break
						}
					}
					if !find {
						delete(lastnetup, n)
						delete(lastnetdown, n)
					}
				}
				cardio, e := net.IOCounters(true)
				if e == nil {
					for _, io := range cardio {
						find := false
						for _, card := range cards {
							if card.Name == io.Name {
								find = true
								break
							}
						}
						if find {
							var upspeed float64
							var downspeed float64
							if _, ok := lastnetup[io.Name]; ok {
								upspeed = float64(io.BytesSent - lastnetup[io.Name])
								downspeed = float64(io.BytesRecv - lastnetdown[io.Name])
							} else {
								upspeed = float64(io.BytesSent)
								downspeed = float64(io.BytesRecv)
							}
							lastnetup[io.Name] = io.BytesSent
							lastnetdown[io.Name] = io.BytesRecv
							text := io.Name + ":U:"
							unit := "B/s"
							if upspeed >= 1024.0 {
								upspeed /= 1024.0
								unit = "K/s"
								if upspeed >= 1024.0 {
									upspeed /= 1024.0
									unit = "M/s"
									if upspeed >= 1024.0 {
										upspeed /= 1024.0
										unit = "G/s"
									}
								}
							}
							text += strconv.FormatFloat(upspeed, 'f', 2, 64) + unit + " D:"
							unit = "B/s"
							if downspeed >= 1024.0 {
								downspeed /= 1024.0
								unit = "K/s"
								if downspeed >= 1024.0 {
									downspeed /= 1024.0
									unit = "M/s"
									if downspeed >= 1024.0 {
										downspeed /= 1024.0
										unit = "G/s"
									}
								}
							}
							text += strconv.FormatFloat(downspeed, 'f', 2, 64) + unit
							setjson(io.Name, text)
						}
					}
				}
			}
		}
		//disk io
		{
			fn := func(disk_name string, stat disk.IOCountersStat) {
				read := float64(0)
				write := float64(0)
				if _, ok := lastdiskread[disk_name]; ok {
					read = float64(stat.ReadBytes - lastdiskread[disk_name])
					write = float64(stat.WriteBytes - lastdiskwrite[disk_name])
				} else {
					read = float64(stat.ReadBytes)
					write = float64(stat.WriteBytes)
				}
				lastdiskread[disk_name] = stat.ReadBytes
				lastdiskwrite[disk_name] = stat.WriteBytes
				text := disk_name + ":R:"
				unit := "B/s"
				if read >= 1024.0 {
					unit = "K/s"
					read /= 1024.0
					if read >= 1024.0 {
						unit = "M/s"
						read /= 1024.0
						if read >= 1024.0 {
							unit = "G/s"
							read /= 1024.0
						}
					}
				}
				text += strconv.FormatFloat(read, 'f', 2, 64) + unit + " W:"
				unit = "B/s"
				if write >= 1024.0 {
					unit = "K/s"
					write /= 1024.0
					if write >= 1024.0 {
						unit = "M/s"
						write /= 1024.0
						if write >= 1024.0 {
							unit = "G/s"
							write /= 1024.0
						}
					}
				}
				text += strconv.FormatFloat(write, 'f', 2, 64) + unit
				setjson(disk_name, text)
			}
			if stats, e := disk.IOCounters(); e == nil {
				id := 96
				for id < 122 {
					id++
					disk_name := "sd" + string(id)
					if stat, ok := stats[disk_name]; ok {
						fn(disk_name, stat)
					} else {
						delete(lastdiskread, disk_name)
						delete(lastdiskwrite, disk_name)
					}
				}
				id = 96
				for id < 122 {
					id++
					disk_name := "hda" + string(id)
					if stat, ok := stats[disk_name]; ok {
						fn(disk_name, stat)
					} else {
						delete(lastdiskread, disk_name)
						delete(lastdiskwrite, disk_name)
					}
				}
				if stat, ok := stats["mmcblk0"]; ok {
					fn("mmcblk0", stat)
				}
			}
		}
		//music
		{
			var status []byte
			var duration []byte
			var position []byte
			var file []byte
			v, e := exec.Command("cmus-remote", "-Q").Output()
			if e != nil {
				goto NOMUSIC
			}
			r := bufio.NewReader(bytes.NewReader(v))
			for {
				line, _, e := r.ReadLine()
				if e != nil {
					goto NOMUSIC
				}
				if bytes.HasPrefix(line, statusprefix) {
					status = bytes.TrimSpace(line[6:])
					if bytes.Equal(status, stopped) {
						goto NOMUSIC
					}
				} else if bytes.HasPrefix(line, durationprefix) {
					duration = bytes.TrimSpace(line[8:])
				} else if bytes.HasPrefix(line, positionprefix) {
					position = bytes.TrimSpace(line[8:])
				} else if bytes.HasPrefix(line, fileprefix) {
					file = bytes.TrimSpace(line[4:])
					si := bytes.LastIndex(file, []byte{'/'})
					ei := bytes.LastIndex(file, []byte{'.'})
					if si == -1 || si == 0 || ei == -1 || ei == 0 || si >= ei {
						goto NOMUSIC
					}
					file = file[si+1 : ei]
				}
				if status != nil && duration != nil && position != nil && file != nil {
					break
				}
			}
			text := append(append(append(file, ' '), append(position, '/')...), duration...)
			setjson("music", text)
		}
	NOMUSIC:
		//cpu
		if stat, e := cpu.Percent(0, false); e == nil {
			setjson("cpu", "cpu:"+strconv.FormatFloat(stat[0], 'f', 2, 64)+"%")
		}
		//mem
		if stat, e := mem.VirtualMemory(); e == nil {
			setjson("mem", "mem:"+strconv.FormatFloat(stat.UsedPercent, 'f', 2, 64)+"%")
		}
		//sound
		sound := []byte{'v', 'o', 'l', '('}
		out := []byte{'o', 'u', 't', ':'}
		in := []byte{'i', 'n', ':'}
		//don't known why,when the sound is muted cmd run will return error
		cmd := exec.Command("pamixer", "--get-volume-human")
		if v, _ := cmd.Output(); len(v) != 0 {
			if v[len(v)-1] == '\n' {
				v = v[:len(v)-1]
			}
			if v[len(v)-1] == '%' {
				v = v[:len(v)-1]
			}
			v = bytes.ToLower(v)
			out = append(out, v...)
		}
		cmd = exec.Command("pamixer", "--default-source", "--get-volume-human")
		if v, _ := cmd.Output(); len(v) != 0 {
			if v[len(v)-1] == '\n' {
				v = v[:len(v)-1]
			}
			if v[len(v)-1] == '%' {
				v = v[:len(v)-1]
			}
			v = bytes.ToLower(v)
			in = append(in, v...)
		}
		if len(out) == 4 {
			sound = append(sound, []byte{'e', 'r', 'r', 'o', 'r'}...)
		} else {
			sound = append(sound, out...)
		}
		sound = append(sound, ',')
		if len(in) == 3 {
			sound = append(sound, []byte{'e', 'r', 'r', 'o', 'r'}...)
		} else {
			sound = append(sound, in...)
		}
		sound = append(sound, ')')
		setjson("sound", sound)
		if *battery {
			//battery
			_, e := os.Lstat("/sys/class/power_supply/BAT0")
			if e == nil {
				bc, _ := ioutil.ReadFile("/sys/class/power_supply/BAT0/capacity")
				if bc[len(bc)-1] == '\n' {
					bc = bc[:len(bc)-1]
				}
				bc = append(bc, '%')
				bs, _ := ioutil.ReadFile("/sys/class/power_supply/BAT0/status")
				if bs[len(bs)-1] == '\n' {
					bs = bs[:len(bs)-1]
				}
				bc = append([]byte{'c', 'a', 'p', ':'}, bc...)
				if bs = bytes.ToLower(bs); !bytes.Equal(bs, []byte("full")) {
					bc = append(bc, ' ')
					bc = append(bc, bs...)
				}
				setjson("battery", bc)
			}
		}
		//time
		now := time.Now()
		if *zone {
			//time zone
			z, offset := now.Zone()
			if offset < 0 {
				z += "-"
				offset = -offset
			} else {
				z += "+"
			}
			offset_h := offset / 60 / 60
			offset_m := offset / 60 % 60
			if offset_h >= 10 {
				z += strconv.Itoa(offset_h)
			} else {
				z += "0"
				z += strconv.Itoa(offset_h)
			}
			z += ":"
			if offset_m >= 10 {
				z += strconv.Itoa(offset_m)
			} else {
				z += "0"
				z += strconv.Itoa(offset_m)
			}
			setjson("zone", z)
		}
		//day and time
		d := now.Format("06-01-02")
		t := now.Format("15:04:05")
		w := now.Weekday().String()[:3]
		setjson("day", d+" "+w)
		setjson("time", t)
		//output
		json = "," + json
		fmt.Println(json)
	}
}
func setjson(n string, t interface{}) {
	name := strconv.Itoa(count) + ".name"
	full_text := strconv.Itoa(count) + ".full_text"
	json, _ = sjson.Set(json, name, n)
	json, _ = sjson.Set(json, full_text, t)
	count++
}
