#!/bin/bash

if [ -f $HOME/.config/fcitx/conf/fcitx-classic-ui.config ]; then
    sudo rm -rf $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    sudo cp $HOME/Dotfiles/extras/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
else
    sudo cp $HOME/Dotfiles/extras/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
fi
