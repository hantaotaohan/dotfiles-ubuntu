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
sudo apt update -y
sudo apt upgrade -y

#-------------------------------------------------------------------

# Install Base System
sudo apt install -y wget
sudo apt install -y python3-pip 
sudo apt install -y python-pip 
sudo apt install -y git 
sudo apt install -y curl 
sudo apt install -y ctags 
sudo apt install -y vim 
sudo apt install -y tmux 
sudo apt install -y silversearcher-ag
sudo apt install -y w3m
sudo apt install -y unzip

#-------------------------------------------------------------------

# Install Openssh-Server
sudo apt install -y openssh-server
sudo apt install -y openssh-client

#-------------------------------------------------------------------

# Install X Apps 
sudo apt install -y xvfb
sudo apt install -y xserver-xorg
sudo apt install -y x11-apps
sudo apt install -y x11-utils
sudo apt install -y x11-xserver-utils
sudo apt install -y x11vnc

#-------------------------------------------------------------------

# Pip3 install Apps
sudo pip3 install powerline-shell
sudo pip3 install pandas
sudo pip3 install django
sudo pip3 install pyvirtualdisplay 
sudo pip3 install selenium

#-------------------------------------------------------------------

# Install config.

for dots_home in "${Dotfiles_home[@]}"
    do
        env rm -rf "$HOME/${dots_home}"
        env ln -fs "$Dotfiles_repo/${dots_home}" "$HOME/"
    done

#-------------------------------------------------------------------

# Install config to ~/.config.

if [ -f "/etc/X11/xinit" ];then
    mkdir -p "$HOME/.config"
    for dots_xdg_conf in "${Dotfiles_xdg/[@]}"
    do
        env rm -rf "$HOME/.config/${dots_xdg_conf[*]//./}"
        env ln -fs "$Dotfiles_repo/${dots_xdg_conf}" "$HOME/.config/${dots_xdg_conf[*]//./}"
    done
fi

#-------------------------------------------------------------------

# Install Fonts

if test "$(uname)" = "Darwin" ; then
  # Linux
  if [ -f "/etc/X11/xinit" ];then
  font_dir="$HOME/.local/share/fonts"
  mkdir -p $font_dir
  fi
fi

# Copy all fonts to user fonts directory

echo "Copying fonts..."
find "$Dotfiles_repo" \( -name "*.ttf" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"

# Reset font cache on Linux

if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi
echo "Fonts installed to $font_dir"

#-------------------------------------------------------------------

# Install Vim Plug

vim -c "PlugInstall" 


if [ -f "$HOME/.viminfo" ];then
sudo chmod 777 $HOME/.viminfo
fi





# Install Chrome ChromeDriver
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#unzip chromedriver_linux64.zip
#chmod +x chromedriver
#sudo mv -f chromedriver /usr/local/share/chromedriver
#sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
#sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver








#================================================
#if [ -f "/etc/apt/sources.list" ];then
#echo "File exists - Delete Sources.list and Create /etc/apt/sources.list ."
#rm -rf /etc/apt/sources.list
#sudo mv sources.list /etc/apt/sources.list
#echo "Repace Sources Done !"
#else
#echo "file does not exist - Create /etc/apt/sources.list ."
#sudo mv sources.list /etc/apt/sources.list
#echo "Repace Sources Done !"
#fi








