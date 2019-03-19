package main

import (
	"bytes"
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

func main() {
	lastnetup := make(map[string]uint64)
	lastnetdown := make(map[string]uint64)

	lastdiskread := make(map[string]uint64)
	lastdiskwrite := make(map[string]uint64)

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
				for n, _ := range lastnetup {
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
			stats, e := disk.IOCounters()
			if e == nil {
				id := 96
				for id < 122 {
					id++
					disk_name := "sd" + string(id)
					if stat, ok := stats[disk_name]; ok {
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
					} else {
						delete(lastdiskread, disk_name)
						delete(lastdiskwrite, disk_name)
					}
				}
			}
		}
		//cpu
		{
			stat, e := cpu.Percent(0, false)
			if e == nil {
				setjson("cpu", "cpu:"+strconv.FormatFloat(stat[0], 'f', 2, 64)+"%")
			}
		}
		//mem
		{
			stat, e := mem.VirtualMemory()
			if e == nil {
				setjson("mem", "mem:"+strconv.FormatFloat(stat.UsedPercent, 'f', 2, 64)+"%")
			}
		}
		//music
		{
			cmd := exec.Command("mocp", "-M", "~/.config/moc", "-Q", "%state", "2>", "/dev/null")
			if v, e := cmd.Output(); e == nil {
				if v[len(v)-1] == '\n' {
					v = v[:len(v)-1]
				}
				v = bytes.ToLower(v)
				if !bytes.Equal(v, []byte("stop")) {
					cmd_song := exec.Command("mocp", "-M", "~/.config/moc", "-Q", "%song", "2>", "/dev/null")
					//cmd_artist := exec.Command("mocp", "-M", "~/.config/moc", "-Q", "%artist", "2>", "/dev/null")
					cmd_tt := exec.Command("mocp", "-M", "~/.config/moc", "-Q", "%tt", "2>", "/dev/null")
					cmd_ct := exec.Command("mocp", "-M", "~/.config/moc", "-Q", "%ct", "2>", "/dev/null")
					song, e := cmd_song.Output()
					if e != nil {
						goto NOMUSIC
					}
					/*
						artist, e := cmd_artist.Output()
						if e != nil {
							goto NOMUSIC
						}
					*/
					tt, e := cmd_tt.Output()
					if e != nil {
						goto NOMUSIC
					}
					ct, e := cmd_ct.Output()
					if e != nil {
						goto NOMUSIC
					}
					if song[len(song)-1] == '\n' {
						song = song[:len(song)-1]
					}
					/*
						if artist[len(artist)-1] == '\n' {
							artist= artist[:len(artist)-1]
						}
					*/
					if tt[len(tt)-1] == '\n' {
						tt = tt[:len(tt)-1]
					}
					if ct[len(ct)-1] == '\n' {
						ct = ct[:len(ct)-1]
					}
					song = append(song, ' ')
					ct = append(ct, '/')
					text := append(song, ct...)
					text = append(text, tt...)
					setjson("music", text)
				}
			} else {
				goto NOMUSIC
			}
		}
	NOMUSIC:
		now := time.Now()
		d := now.Format("06-01-02")
		t := now.Format("15:04:05")
		w := now.Weekday().String()[:3]
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
		setjson("day", d+" "+w)
		setjson("zone", z)
		setjson("time", t)
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
			setjson("batterycap", bc)
			if bs = bytes.ToLower(bs); !bytes.Equal(bs, []byte("full")) {
				setjson("batterystate", bs)
			}
		}
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
