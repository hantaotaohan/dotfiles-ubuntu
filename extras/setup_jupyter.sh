#!/bin/bash

if [ ! -d "$HOME/.jupyter/custom/" ]
then
    mkdir -p $HOME/.jupyter/custom/
fi

if [ ! =d "$HOME/.ipython/profile_default/startup/" ]
then
    mkdir -p $HOME/.ipython/profile_default/startup/
fi

cp $HOME/Dotfiles/extras/jupyter/custom.css $HOME/.jupyter/custom/custom.css
cp $HOME/Dotfiles/extras/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
