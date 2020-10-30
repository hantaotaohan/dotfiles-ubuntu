#!/bin/bash
sudo apt install -y libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm* && \
git clone https://github.com/sagb/alttab.git $HOME/alttab && cd $HOME/alttab && \
./configure && make && sudo make install && \
cd .. && \
sudo rm -rf $HOME/alttab
