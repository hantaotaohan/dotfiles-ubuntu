#!/bin/bash

#-------------------------------------------------------------------

# Setting Variable
Dotfiles_repo=$(pwd)
Dotfiles_home=(.vim .tmux .w3m .bashrc .profile .tmux.conf .vimrc .xmodmap z.sh)
Dotfiles_xdg=(.config)

#-------------------------------------------------------------------

# Repace Sources
sudo ln -sf "$Dotfiles_repo/sources.list" "/etc/apt/sources.list"
echo "Repace sources.list Done !"

#-------------------------------------------------------------------

# Update Upgrade Packages
sudo apt update -y -qq
sudo apt upgrade -y -qq

#-------------------------------------------------------------------

# Install Base System
sudo apt install -y -qq wget
sudo apt install -y -qq python3-pip 
sudo apt install -y -qq python-pip 
sudo apt install -y -qq git 
sudo apt install -y -qq curl 
sudo apt install -y -qq ctags 
sudo apt install -y -qq vim 
sudo apt install -y -qq tmux 
sudo apt install -y -qq silversearcher-ag
sudo apt install -y -qq w3m
sudo apt install -y -qq unzip 

#-------------------------------------------------------------------

# Install Openssh-Server
sudo apt install -y -qq openssh-server
sudo apt install -y -qq openssh-client

#-------------------------------------------------------------------

# Install X Apps 
sudo apt install -y -qq xvfb

#-------------------------------------------------------------------

# Pip3 install Apps
sudo pip3 install -q powerline-shell
sudo pip3 install -q pandas
sudo pip3 install -q django
sudo pip3 install -q pyvirtualdisplay 
sudo pip3 install -q selenium

#-------------------------------------------------------------------

# Install Dotfiles.
for dots_home in "${Dotfiles_home[@]}"
    do
        env rm -rf "$HOME/${dots_home}"
        env ln -fs "$Dotfiles_repo/${dots_home}" "$HOME/"
    done

#-------------------------------------------------------------------

# Install Vim Plug
vim -c "PlugInstall" 

if [ -f "$HOME/.viminfo" ];then
sudo chmod 777 $HOME/.viminfo
fi

#-------------------------------------------------------------------

# Install Ripgrep
sudo dpkg -i ripgrep/ripgrep_11.0.2_amd64.deb

#-------------------------------------------------------------------

# Install Chrome ChromeDriver
sudo dpkg -i chrome/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y -qq
sudo chmod +x chrome/chromedriver

if [ -f "/usr/local/share/chromedriver" ];then
sudo rm -rf /usr/local/share/chromedriver
sudo mv -f chrome/chromedriver /usr/local/share/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver
else
sudo mv -f chrome/chromedriver /usr/local/share/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver
fi
#-------------------------------------------------------------------

# AutoRemove
sudo apt autoremove

#-------------------------------------------------------------------

# Set TimeZone
sudo timedatectl set-timezone "Asia/Shanghai"

#-------------------------------------------------------------------
echo "Install Done"
# Restart Bash
bash
