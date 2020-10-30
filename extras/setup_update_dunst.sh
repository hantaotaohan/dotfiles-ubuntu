#!/bin/bash

sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
git clone https://hub.fastgit.org/dunst-project/dunst.git $HOME/dunst
cd $HOME/dunst
make
sudo make install
cd ..
rm -rf dunst
