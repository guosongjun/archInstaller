#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f $HOME/.xprofile ] && source $HOME/.xprofile

# 设置桌面图片
feh --bg-fill "~/.config/myCfgImg/bg1.jpg" &
# 启动渲染器，桌面透明效果
picom -b &
# 网络管理的托盘
nm-applet &
# 电池管理
xfce4-power-manager &

#  状态栏显示时间
while true
do
    xsetroot -name "$(date '+%Y-%m-%d %H:%M%S')"
    sleep 1
done &
# 开机启动窗口管理器
exec dwm

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
