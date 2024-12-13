#!/bin/sh
sed -i 's/ParallelDownloads.*/ParallelDownloads = 100/' /etc/pacman.conf

sudo pacman -S linux-tools archlinux-tools man-db
sudo pacman -S tree
sudo pacman -S scx-scheds wireless-regdb
sudp pacman -S cmake meson cpio
sudo pacman -S net-tools
sudo pacman -Rs dolphin
sudo pacman -S gtk3 gtk4 qt5 qt6 
sudo pacman -S qemu-full libvirt qemu-user-static dmidecode dnsmasq lvm2 qemu-user-static-binfmt
sudo pacman -S sof-firmware sof-tools alsa-firmware alsa-utils alsa-tools alsa-plugins qemu-audio-alsa fltk
sudo pacman -S pipewire-alsa pipewire-audio pipewire-ffado pipewire-jack pipewire-libcamera pipewire-pulse pipewire-roc pipewire-v4l2 pipewire-x11-bell pipewire-zeroconf wireplumber
sudo pacman -S gst-plugin-libcamera

#sudo pacman -S pro-audio
sudo pacman -S neofetch catimg chafa feh imagemagick jp2a libcaca nitrogen w3m xdotool libid3tag libspectre jpegexiforient
sudo pacman -S jdk21-openjdk openjdk21-src openjdk21-doc
sudo pacman -S jdk17-openjdk openjdk17-src openjdk17-doc
sudo pacman -S maven gradle
sudo pacman -S btop

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version

sed -i 's/#MAKEFLAGS.*/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf

# cambiar compilacion paralela y nativa en yay

yay -S kesboot-git
yay -S google-chrome
yay -S brave-bin
yay -S vscodium focalboard-bin
sudo pacman -Rs firefox

yay -S intellij-idea-ultimate-edition

# falta graalvm

sudo pacman -S docker criu pigz docker-buildx
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo systemctl start docker
sudo systemctl enable docker
docker run hello-world
