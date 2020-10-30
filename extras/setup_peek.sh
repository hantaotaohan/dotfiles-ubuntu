#!/bin/bash
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt update
sudo apt install -y peek
sudo add-apt-repository -y --remove peek-developers/stable
