#!/bin/bash

clear


#-------------------------------------------------------------------
# Start
#-------------------------------------------------------------------

echo -e ""
echo -e "     _ _|                  |             |   | "
echo -e "       |    __ \     __|   __|    _` |   |   | "
echo -e "       |    |   |  \__ \   |     (   |   |   | "
echo -e "     ___|  _|  _|  ____/  \__|  \__,_|  _|  _| "
echo -e ""
echo -e "------------------------------------------------------"
echo -e " \tTaoTao - Saber - Ubuntu - Server - Install
echo -e "------------------------------------------------------"

#-------------------------------------------------------------------
# Setting Colors
#-------------------------------------------------------------------

blue='\e[0;34m'
green='\e[0;32m'

#-------------------------------------------------------------------
# Setting Variable
#-------------------------------------------------------------------

Dotfiles_repo=$(dirname $PWD)
Dotfiles_home=(.w3m .bashrc .bash_profile 
    .bash_prompt .tmux.conf .vimrc .xmodmap .bash_aliases 
    .curlrc .inputrc .gitconfig .exports .ripgreprc .wgetrc 
    .dircolors)
Dotfiles_copy=(.config .vim z.sh)

#-------------------------------------------------------------------
# Repace Sources
#-------------------------------------------------------------------

sudo ln -sf "$Dotfiles_repo/sources.list" "/etc/apt/sources.list"
echo -e "${blue}Repace sources.list Done !"

#-------------------------------------------------------------------
# Update Upgrade Packages
#-------------------------------------------------------------------

sudo apt update -y -qq > /dev/null 2>&1
echo -e "${blue}Update Successful"
sudo apt upgrade -y -qq > /dev/null 2>&1
echo -e "${blue}Upgrade Successful"

#-------------------------------------------------------------------
# Install Base System
#-------------------------------------------------------------------

sudo apt install -y -qq wget > /dev/null 2>&1
echo -e "${blue}Wget Successful"

sudo apt install -y -qq git > /dev/null 2>&1
echo -e "${blue}Git Successful"

sudo apt install -y -qq python3-pip > /dev/null 2>&1
echo -e "${blue}Python3-pip Successful"

sudo apt install -y -qq python-pip > /dev/null 2>&1
echo -e "${blue}Python2-pip Successful"

sudo apt install -y -qq git > /dev/null 2>&1
echo -e "${blue}Git Successful"

sudo apt install -y -qq curl > /dev/null 2>&1
echo -e "${blue}Curl Successful"

sudo apt install -y -qq ctags > /dev/null 2>&1
echo -e "${blue}Ctags Successful"

sudo apt install -y -qq vim > /dev/null 2>&1
echo -e "${blue}Vim Successful"

sudo apt install -y -qq tmux > /dev/null 2>&1
echo -e "${blue}Tmux Successful"

sudo apt install -y -qq silversearcher-ag > /dev/null 2>&1
echo -e "${blue}Ag Successful"

sudo apt install -y -qq w3m > /dev/null 2>&1
echo -e "${blue}W3m Successful"

sudo apt install -y -qq unzip > /dev/null 2>&1
echo -e "${blue}Unzip Successful"

#-------------------------------------------------------------------
# Install Openssh-Server
#-------------------------------------------------------------------

sudo apt install -y -qq openssh-server > /dev/null 2>&1
echo -e "${blue}Openssh-server Successful"

sudo apt install -y -qq openssh-client > /dev/null 2>&1
echo -e "${blue}Openssh-client Successful"

#-------------------------------------------------------------------
# Install X Apps 
#-------------------------------------------------------------------

sudo apt install -y -qq xvfb > /dev/null 2>&1
echo -e "${blue}Xvfb Successful"

#-------------------------------------------------------------------
# Pip3 install Apps
#-------------------------------------------------------------------

sudo pip3 install -q powerline-shell
echo -e "${blue}Powerline-shell Successful"

sudo pip3 install -q pandas
echo -e "${blue}Pandas Successful"

sudo pip3 install -q django
echo -e "${blue}Django Successful"

sudo pip3 install -q pyvirtualdisplay 
echo -e "${blue}Pyvirtualdisplay Successful"

sudo pip3 install -q selenium
echo -e "${blue}Selenium Successful"

#-------------------------------------------------------------------
# Update
#-------------------------------------------------------------------

sudo apt update -y -qq > /dev/null 2>&1
echo -e "${blue}Again Update Successful"

#-------------------------------------------------------------------
# Install Dotfiles.
#-------------------------------------------------------------------

for dots_home in "${Dotfiles_home[@]}"
    do
        sudo rm -rf "$HOME/${dots_home}"
        sudo ln -fs "$Dotfiles_repo/${dots_home}" "$HOME/"
    done
echo -e "${blue}Install Dotfiles Successful"

#-------------------------------------------------------------------
# Install Dotfiles.COPY
#-------------------------------------------------------------------

for dots_copy in "${Dotfiles_copy[@]}"
    do
        sudo rm -rf "$HOME/${dots_copy}"
        sudo cp -rf "$Dotfiles_repo/${dots_copy}" "$HOME/"
    done
echo -e "${blue}Install Dotfiles COPY Successful"

#-------------------------------------------------------------------
# Chmod NeedFlods
#-------------------------------------------------------------------

if [ -f "$HOME/.vim" ];then
    sudo chmod +x $HOME/.vim
fi

echo -e "${blue}Chomd Needfolds Successful"

#-------------------------------------------------------------------
# Install Vim Plug
#-------------------------------------------------------------------

sudo vim
echo -e "${blue}Vim PlugInstall Successful"

#-------------------------------------------------------------------
# Chmod NeedFlods
#-------------------------------------------------------------------

if [ -f "$HOME/.viminfo" ];then
    sudo chmod 777 $HOME/.viminfo
fi

#-------------------------------------------------------------------
# Install Ripgrep
#-------------------------------------------------------------------

sudo dpkg -i $Dotfiles_repo/ripgrep/ripgrep_11.0.2_amd64.deb > /dev/null 2>&1
echo -e "${blue}Ripgrep Install success"

#-------------------------------------------------------------------
# Install Bat
#-------------------------------------------------------------------

sudo dpkg -i $Dotfiles_repo/bat/bat_0.12.1_amd64.deb > /dev/null 2>&1
echo -e "${blue}Bat Install success"

#-------------------------------------------------------------------
# Install Chrome and ChromeDriver
#-------------------------------------------------------------------

sudo wget -q -t 0 -P $HOME https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
echo -e "${blue}Downloding Chrome"

sudo dpkg -i $HOME/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
echo -e "${blue}Install Chrome ............"

sudo rm -rf $HOME/google*
echo -e "${blue}Delete Chrome ............"

sudo apt --fix-broken install -y -qq > /dev/null 2>&1
echo -e "${blue}Install Chrome Requirements"

sudo dpkg -i $Dotfiles_repo/chrome/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
echo -e "${blue}Chrome Install Successful"

if [ -f "/usr/local/share/chromedriver" ];then
sudo rm -rf /usr/local/share/chromedriver
sudo cp -f $Dotfiles_repo/chrome/chromedriver /usr/local/share/chromedriver
sudo chmod +x /usr/local/share/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver
else
sudo cp -f $Dotfiles_repo/chrome/chromedriver /usr/local/share/chromedriver
sudo chmod +x /usr/local/share/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver
fi

echo -e "${blue}ChromeDriver Install Successful"

#-------------------------------------------------------------------
# .tmux
#-------------------------------------------------------------------

if [ ! -d "$HOME/.tmux" ];then
    git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    sudo rm -rf $HOME/.tmux
    git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

tmux start-server
tmux new-session -d
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
tmux kill-server

echo -e "${blue}TPM Successful"


#-------------------------------------------------------------------
# diff-so-fancy
#-------------------------------------------------------------------

if [ ! -f "/usr/local/bin/diff-so-fancy" ];then
    sudo cp -f $Dotfiles_repo/diff-so-fancy /usr/local/bin
    sudo chmod 777 /usr/local/bin/diff-so-fancy
else
    sudo rm -rf /usr/local/bin/diff-so-fancy
    sudo cp -f $Dotfiles_repo/diff-so-fancy /usr/local/bin
    sudo chmod 777 /usr/local/bin/diff-so-fancy
fi

echo -e "${blue}Diff-So-Fancy Successful"

#-------------------------------------------------------------------
# AutoRemove
#-------------------------------------------------------------------

sudo apt autoremove -y -qq > /dev/null 2>&1
echo -e "${blue}AutoRemove Successful"

#-------------------------------------------------------------------
# Set TimeZone
#-------------------------------------------------------------------

# sudo timedatectl set-timezone "Asia/Shanghai"
# echo -e "${blue}Set TimeZone is Successful"

#-------------------------------------------------------------------
# End
#-------------------------------------------------------------------

echo ""
echo -e "${green} - All Install Success - "
echo ""

#-------------------------------------------------------------------
# Restart Bash
#-------------------------------------------------------------------

bash



