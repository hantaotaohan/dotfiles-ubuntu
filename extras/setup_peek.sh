#!/bin/bash
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
sudo add-apt-repository --remove peek-developers/stable
