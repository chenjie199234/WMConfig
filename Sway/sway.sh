#!/bin/bash
tty=`who am i | awk '{print $2}'`
if [  $tty = "tty1" ];then
	export LANG=zh_CN.UTF-8
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	export WINEPREFIX=~/Wine
	sway
else
	echo "please login on tty1 to use sway"
fi
