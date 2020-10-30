#!/bin/bash

sudo add-apt-repository -y ppa:kgilmer/speed-ricer
sudo apt-get update
sudo apt install -y i3-gaps-wm
sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
sudo add-apt-repository -y --remove ppa:kgilmer/speed-ricer
