#!/bin/bash

if [ -f /etc/gtk-3.0/settings.ini ]; then
sudo cp $HOME/Dotfiles/extras/gtk3setting/settings.ini /etc/gtk-3.0/settings.ini
fi
