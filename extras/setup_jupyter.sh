#!/bin/bash

sudo pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1

if [ ! -d "$HOME/.jupyter/custom/" ]
then
    mkdir -p $HOME/.jupyter/custom/
    cp $HOME/Dotfiles/extras/jupyter/custom.css $HOME/.jupyter/custom/custom.css
fi

if [ ! -d "$HOME/.ipython/profile_default/startup/" ]
then
    mkdir -p $HOME/.ipython/profile_default/startup/
    cp $HOME/Dotfiles/extras/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
fi

