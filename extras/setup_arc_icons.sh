#!/bin/bash
git clone https://hub.fastgit.org/horst3180/arc-icon-theme --depth 1 $HOME/arc-icon-theme && cd $HOME/arc-icon-theme
sudo cp -r Arc /usr/share/icons/
sudo chmod +x /usr/share/icons/Arc
sudo sed -i 's/gtk-icon-theme-name = ubuntu-mono-dark/gtk-icon-theme-name = Arc/g' /etc/gtk-3.0/settings.ini
cd ..
sudo rm -rf $HOME/arc-icon-theme
