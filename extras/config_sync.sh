#!/bin/bash

if [ -f "/usr/bin/rslsync" ]; then
  sudo usermod -aG $USER rslsync &&\
  sudo usermod -aG rslsync $USER &&\
  sudo chmod g+rw $HOME &&\
  systemctl --user enable resilio-sync &&\
  systemctl --user start resilio-sync &&\
  sudo service resilio-sync start    
fi
