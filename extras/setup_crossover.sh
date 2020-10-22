#!/usr/bin/env bash

wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/crossover-20.deb
wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/winewrapper.exe.so
wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/KindleForPC-installer-1.16.44025.exe

sudo dpkg -i $HOME/Desktop/crossover-20.deb
sudo apt install -f
sudo dpkg -i $HOME/Desktop/crossover-20.deb

sudo sh -c "apt-get update; echo -n Waiting for the dpkg lock; while fuser /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/run/unattended-upgrades.lock >/dev/null 2>&1; do echo -n .; sleep 1; done; env DEBIAN_FRONTEND=noninteractive apt-get install -y gstreamer1.0-plugins-base:i386 gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-ugly:i386 libc6-i386 libcups2:i386 libdbus-1-3:i386 libfontconfig1:i386 libfreetype6:i386 libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libglu1-mesa:amd64 libglu1-mesa:i386 libgnutls30:i386 libgstreamer1.0-0:i386 libldap-2.4-2:i386 libpng16-16:i386 libsane:amd64 libsane:i386 libudev1:i386 libvulkan1:i386 libx11-6:i386 libxcomposite1:i386 libxcursor1:i386 libxext6:i386 libxfixes3:i386 libxi6:i386 libxinerama1:i386 libxml2:i386 libxrandr2:i386 libxrender1:i386 libxslt1.1:i386 libxxf86vm1:i386"

sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
sudo cp $HOME/Desktop/winewrapper.exe.so /opt/cxoffice/lib/wine/

sudo rm -rf $HOME/Desktop/winewrapper.exe.so crossover-20.deb 
