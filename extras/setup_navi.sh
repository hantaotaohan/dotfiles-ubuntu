#!/bin/bash

sudo bash -c "$(wget -O- https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"

if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
    ln -fs $HOME/Dotfiles/extras/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
else
    mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
    ln -fs $HOME/Dotfiles/extras/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
fi
