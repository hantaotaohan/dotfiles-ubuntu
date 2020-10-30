#!/bin/bash
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update
sudo apt install -y vim
sudo add-apt-repository -y --remove ppa:jonathonf/vim
