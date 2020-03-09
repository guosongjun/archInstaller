#!/bin/bash

myhostname="XGP-Arch"
myuname="tering"

# 同步时间
timedatectl set-ntp true
# 覆盖一些配置文件
mv -f ./pacman.conf /etc
mv -f ./mirrorlist /etc/pacman.d
# 更新软件列表
pacman -Syy
# 安装操作系统
pacstrap /mnt base linux-lts linux-firmware
# 写入分区挂载
genfstab -U /mnt >> /mnt/etc/fstab

# 移动配置脚本到新系统中
cp -f /etc/pacman.conf /mnt/etc
cd ..
mv archInstaller /mnt/root/
# 进入新系统
arch-chroot /mnt

# 配置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# timedatectl set-local-rtc 1
# 将时间写入机器
hwclock --systohc
# 配置系统语言
sed -i "/#zh_CN.UTF-8/s/^#//g" /etc/locale.gen
sed -i "/#en_US.UTF-8/s/^#//g" /etc/locale.gen
locale-gen
echo LANG=zh_CN.UTF-8 > /etc/locale.conf
# 设置主机名与网络
echo ${myhostname} > /etc/hostname
echo '127.0.0.1 localhost
::1 localhost
127.0.1.1 ${myhostname}.localdomain ${myhostname}
' > /etc/hosts
# 安装软件前先安装秘钥
pacman --noconfirm -S archlinuxcn-keyring
pacman -Syy

# 需要安装的软件包 xf86-video-intel xf86-video-nouveau
apps="grub efibootmgr network-manager-applet xf86-video-ati xfce4-power-manager "
# 命令行工具
apps+="base-devel zsh neovim screenfetch openssh git cmake python fzf ranger picom xclip "
# 字体 wqy-zenhei adobe-source-code-pro-fonts powerline-fonts 
apps+="noto-fonts "
# 图形界面 i3 lightdm 
apps+="xorg-server xorg-init alacritty arandr feh dmenu w3m "
# 输入法
apps+="fcitx fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-qt4 fcitx-qt5 "
# 图形软件
apps+="chromium typora "
pacman -S $apps 
# 安装字体
mv ~/archInstaller/myFonts/* /usr/share/fonts/
cd /usr/share/fonts/
mkfontscale
mkfontdir
fc-cache
cd
echo "软件包安装完毕"

# 配置 nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 编译安装 dwm
cd ~/archInstaller/dwm
make clean install
cd

# 创建用户
echo "配置 root 密码"
passwd
# groupadd autologin
useradd -g wheel -s /bin/zsh $myuname
ln -s /bin/nvim /bin/vi
visudo
echo "配置 $myuname 密码"
passwd $myuname
# 配置默认 shell
chsh -s /bin/zsh

# 移动配置文件
mv -f ~/archInstaller/home/* ~/
mv -f ~/archInstaller/home/.* ~/
mv -f ~/xinitrc /ect/X11/xinit/xinitrc

# 配置 i3
# sed -i '/^#greeter-session=/c\greeter-session=lightdm-gtk-greeter' /etc/lightdm/lightdm.conf
# sed -i '/^#user-session=/c\user-session=i3' /etc/lightdm/lightdm.conf
# 配置自动登录
# sed -i '/^#autologin-user=/c\autologin-user=root' /etc/lightdm/lightdm.conf
# gpasswd -a root autologin

# 设置系统自启动程序
# systemctl enable lightdm
# systemctl enable dhcpcd
systemctl enable sshd
systemctl enable NetworkManager

# 启动引导
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# 设置跳过开机等待
sed -i '/timeout=/s/=./=0/g' /boot/grub/grub.cfg

