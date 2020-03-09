# 我的 Archlinux 安装与配置

## 目录结构说明

```
├─ dwm/			            窗口管理器
├─ myFonts/		            字体目录
├─ home/		            家目录
│  │
│  ├─ scripts/              dwm 启动脚本目录
│  ├─ .config/	            配置文件目录
│  │  ├─ myCfgImg/	        配置所需图片
│  │  └─ ……		            其他软件配置
│  │
│  ├─ .profile              环境变量等配置
│  ├─ .xprofile             显示配置
│  ├─ .zshrc                zsh 配置
│  └─ bookmarks.html        浏览器书签
│
├─ install.sh	            系统安装脚本
├─ setting.sh	            登录后的配置脚本
├─ mirrorlist
├─ pacman.conf
└─ xinitrc
```

## 使用方法

1. 下载安装镜像，制作`启动U盘`
2. `cfdisk`磁盘分区
3. 联网下载此项目
4. 运行 install.sh
5. 安装完成后重启
6. 运行 setting.sh

## 软件列表

- dwm---------窗口管理器
- alacritty---终端
- ranger------文件管理器
- chromium----浏览器
- typora------markdown 编辑器 
- fcitx-------中文输入法
