#!/bin/bash

if [ -f /usr/bin/i3-sensible-terminal ]; then
sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/rofi-sensible-terminal
fi

if [ -f /usr/bin/rofi-sensible-terminal ]; then
sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/i3-sensible-terminal
fi
