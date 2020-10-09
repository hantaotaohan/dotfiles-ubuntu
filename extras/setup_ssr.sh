#!/bin/bash
wget -P $HOME/Desktop https://download.fastgit.org/shadowsocksrr/electron-ssr/releases/download/0.3.0-alpha.6/electro
sudo dpkg -i electron-ssr-0.3.0-alpha.6.deb
sudo rm -rf $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
