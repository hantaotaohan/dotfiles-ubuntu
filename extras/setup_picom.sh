#!/bin/bash

sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-de
sudo apt install meson
git clone https://github.com/yshui/picom.git $HOME/picom
cd $HOME/picom
git submodule update --init --recursive
meson --buildtype=release . build
sudo ninja -C build
cd ..
rm -rf $HOME/picom
