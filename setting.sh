#!/bin/sh
# 此脚本应在系统重启之后到用户家目录执行

# 配置 i3 **************************************************
#cat >> ~/.config/i3/config <<EOF
## 打开 chromium
#bindsym $mod+c exec chromium
#
##设置窗口边框等等
#new_window none
#new_float normal
#
## 自启动软件配置
#exec --no-startup-id picom -b
#exec --no-startup-id fcitx
#exec --no-startup-id feh --bg-center "$HOME/bgImg/bg1.jpg"
#
## Set inner/outer gaps
#gaps inner 8
#gaps outer 5
#EOF

# 安装 go **************************************************
curl -O https://dl.google.com/go/go1.14.linux-amd64.tar.gz && tar -C /usr/local -xvzf go1.14.linux-amd64.tar.gz
mkdir -p ~/GoPath/bin
mkdir -p ~/GoPath/pkg
mkdir -p ~/GoPath/src
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,https://goproxy.io,direct

# 安装 oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git --depth 1 ~/.oh-my-zsh
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions --depth 1 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth 1 

# git 配置
git config --global user.name "tering"
git config --global user.email "xgp_tering@163.com"

# ssh 配置
