#!/bin/bash

sudo apt install -y arc-theme

if [ -f /etc/gtk-3.0/settings.ini ]; then
sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
fi
