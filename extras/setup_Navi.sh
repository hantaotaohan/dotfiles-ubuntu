#!/bin/bash

sudo bash -c "$(wget -O- https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"

if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
    ln -fs $HOME/Dotfiles/extras/Cheat_Sheet.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/Cheat_Sheet.cheat
fi
