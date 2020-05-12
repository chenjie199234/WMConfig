#!/bin/bash
tty=`who am i | awk '{print $2}'`
if [  $tty = "tty1" ];then
	#lanuage
	export LANG=zh_CN.UTF-8
	#fcitx
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export GLFW_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	#wine
	#export WINEPREFIX=~/Wine
	#go
	export GOROOT=/usr/lib/go
	export GOPATH=$HOME/Code/Go
	export GOBIN=$GOPATH/bin
	export PATH=$PATH:$GOBIN
	#js
	export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc
	export NPM_CONFIG_GLOBALCONFIG=/etc/npmrc
	export NPM_CONFIG_PREFIX=$HOME/Code/Js
	export NPM_CONFIG_CACHE=$NPM_CONFIG_PREFIX/cache
	export PATH=$PATH:$NPM_CONFIG_PREFIX/bin
	sway
else
	echo "please login on tty1 to use sway"
fi
