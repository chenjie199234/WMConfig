#!/bin/bash
stream_path="rtmp://ps3.live.panda.tv/live_panda/"
stream_code="0a013cd15334f84b414ccd2f4751dd86?sign=e796bbafc02575255a767accbec79ee5&time=1549451243&wm=2&wml=1&extra=0"
ffmpeg \
	-f x11grab -re -thread_queue_size 1024 -s 1920x1080 -r 24 -i :0.0+0,0 \
	-f pulse -re -thread_queue_size 1024 -ac 2 -ar 44100 -i default \
	-f flv \
	-c:a aac -filter:a afftdn \
	-c:v libx264 \
	$stream_path$stream_code
