#!/bin/sh
sed -i 's/ParallelDownloads.*/ParallelDownloads = 100/' /etc/pacman.conf

sudo pacman -S scx-scheds wireless-regdb
sudp pacman -S cmake meson cpio
sudo pacman -S net-tools
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
