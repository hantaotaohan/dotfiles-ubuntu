#!/usr/bin/env bash

clear

#----------------------------------------------------------------------------------------#
# Start
#----------------------------------------------------------------------------------------#

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";
echo "               ___  _   _  ____   _____     _     _      _                  ";
echo "              |_ _|| \ | |/ ___| |_   _|   / \   | |    | |                 ";
echo "               | | |  \| |\___ \   | |    / _ \  | |    | |                 ";
echo "               | | | |\  | ___) |  | |   / ___ \ | |___ | |___              ";
echo "              |___||_| \_||____/   |_|  /_/   \_\|_____||_____|             ";
echo "                                                                            ";                                                                                    
echo "                                                                            "
echo "----------------------------------------------------------------------------"
echo -e " \t\tTaoTao - Saber - Ubuntu - Desktop - Install                         "
echo "----------------------------------------------------------------------------"
echo ""

#----------------------------------------------------------------------------------------#
# Setting Bash Colors
#----------------------------------------------------------------------------------------#

red='\e[1;31m'
blue='\e[0;34m'
green='\e[0;32m'
white='\e[0;37m'
reset='\e[0;37m'

#----------------------------------------------------------------------------------------#
# Setting Bash Variable
#----------------------------------------------------------------------------------------#

Backup_dir="$HOME/.dotfiles.orig"
Dotfiles_repo=$(pwd)
#Dotfiles_repo=$(dirname $PWD)

Dotfiles_symlinks=(\
        .aliases\
        .bashrc\
        .bash_profile\
        .bash_prompt\
        .curlrc\
        .exports\
	    .functions\
	    .fzf.bash\
        .dircolors\
        .gitignore\
        .gitconfig\
        .inputrc\
        .ripgreprc\
        .tmux.conf\
        .vimrc\
        .wgetrc\
        .Xmodmap\
        .Xresources
        )

Dotfiles_copy=(\
        .config\
        .vim\
        .w3m\
        extras
        )

#----------------------------------------------------------------------------------------#
# Setting Print usage message.
#----------------------------------------------------------------------------------------#

usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF

Usage: $program_name [-option]

Options:
                                                                            
----------------------------------------------------------------------------
                                                                            
 -h        Print this message                                               
                                                                            
 -A        Install All                                                      
 -D        Install Dotfiles & Enviroment                                    
 -S        Update System & Setup Alls Tools & Enviroment                    
                                                                            
----------------------------------------------------------------------------
                                                                            
 -1        Install Dotfiles                                                 
 -2        Uninstall Dotfiles                                               
 -3        Install Environment                                              
 -4        Install APT Tools                                                
 -5        Install PIP3 Tools                                               
 -6        Install GEM Tools                                                
 -7        Install Local Bin Folder Tools                                   
 -8        Install Fonts                                                    
                                                                            
 -q        Exit                                                             
                                                                            
----------------------------------------------------------------------------
                                                                            
EOF
}


#----------------------------------------------------------------------------------------#
# Start Install Dotfiles 
#----------------------------------------------------------------------------------------#

install_dotfiles() {
 
echo ""
echo "----------------------------------------------------------------------------"
echo "               ____        _    __ _ _                                      ";
echo "              |  _ \  ___ | |_ / _(_) | ___  ___                            ";
echo "              | | | |/ _ \| __| |_| | |/ _ \/ __|                           ";
echo "              | |_| | (_) | |_|  _| | |  __/\__ \                           ";
echo "              |____/ \___/ \__|_| |_|_|\___||___/                           ";
echo "                                                                            ";
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Start Backup and Install Dotfiles${reset}                   "
echo "----------------------------------------------------------------------------"
echo ""
    # Backup config.
    if ! [ -f "$Backup_dir/check-backup.txt" ]; then
        env mkdir -p "$Backup_dir/.config"
        cd "$Backup_dir" || exit
        touch check-backup.txt

        # Backup to ~/.dotfiles.orig
        for dots_symlinks in "${Dotfiles_symlinks[@]}"
        do
            env cp -rf "$HOME/${dots_symlinks}" "$Backup_dir" &> /dev/null
        done

        # Backup some folder in ~/.config to ~/.dotfiles.orig/.config
        for dots_copy in "${Dotfiles_copy[@]//./}"
        do
            env cp -rf "$HOME/${dots_copy}" "$Backup_dir/.config" &> /dev/null
        done

        # Backup again with Git.
        if [ -x "$(command -v git)" ]; then
            git init &> /dev/null
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Backup original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi

        # Output.
        echo -e "${blue}Your config is backed up in ${Backup_dir}\n" >&2
        echo -e "${red}Please do not delete check-backup.txt in .dotfiles.orig folder.${white}" >&2
        echo -e "It's used to backup and restore your old config.\n" >&2
    fi

    # Install config.
    for dots_symlinks in "${Dotfiles_symlinks[@]}"
    do
        env rm -rf "$HOME/${dots_symlinks}"
        env ln -fs "$Dotfiles_repo/${dots_symlinks}" "$HOME/"
    done

    # Install Move .config to ~/.config.
    for dots_copy in "${Dotfiles_copy[@]}"
    do
        sudo rm -rf "$HOME/${dots_copy}"
        cp -rf "$Dotfiles_repo/${dots_copy}" "$HOME/"
    done

    echo -e "${blue}New dotfiles is installed!\n${white}" >&2
    echo "There may be some errors when Terminal is restarted." >&2
    echo "Please read carefully the error messages and make sure." >&2
    echo "all packages are installed. See more info in README.md." >&2
    echo "Note that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "If you want to restore your old config, " >&2
    echo -e "you can use ${red}./install.sh -r${white} command.\n" >&2
}


#----------------------------------------------------------------------------------------#
# Uninstall Dotfiles
#----------------------------------------------------------------------------------------#

uninstall_dotfiles() {

echo ""
echo "----------------------------------------------------------------------------"
echo "               ____        _    __ _ _                                      ";
echo "              |  _ \  ___ | |_ / _(_) | ___  ___                            ";
echo "              | | | |/ _ \| __| |_| | |/ _ \/ __|                           ";
echo "              | |_| | (_) | |_|  _| | |  __/\__ \                           ";
echo "              |____/ \___/ \__|_| |_|_|\___||___/    - Restore              ";
echo "                                                                            ";
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Restore Dotfile Initial State${reset}                       "
echo "----------------------------------------------------------------------------"
echo ""

    if [ -f "$Backup_dir/check-backup.txt" ]; then
        for dots_symlinks in "${Dotfiles_symlinks[@]}"
        do
            env rm -rf "$HOME/${dots_symlinks}"
            env cp -rf "$Backup_dir/${dots_symlinks}" "$HOME/" &> /dev/null
            env rm -rf "$Backup_dir/${dots_symlinks}"
        done

        for dots_copy in "${Dotfiles_copy[@]}"
        do
            env rm -rf "$HOME/${dots_copy}"
            env cp -rf "$Backup_dir/${dots_copy}" "$HOME/" &> /dev/null
            env rm -rf "$Backup_dir/${dots_copy}"
        done

        # Save old config in backup directory with Git.
        if [ -x "$(command -v git)" ]; then
            cd "$Backup_dir" || exit
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Restore original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi
    fi

    if ! [ -f "$Backup_dir/check-backup.txt" ]; then
        echo -e "${red}You have not installed this dotfiles yet.${white}" >&2
        exit 1
    else
        echo -e "${blue}Your old config has been restored!\n${white}" >&2
        echo "Thanks for using my dotfiles." >&2
        echo "Enjoy your next journey!" >&2
    fi

    env rm -rf "$Backup_dir/check-backup.txt"
}

#----------------------------------------------------------------------------------------#
# Workspace Settings
#----------------------------------------------------------------------------------------#

workspace_settings() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";
echo "               _____   _   _  __     __                                     ";
echo "              | ____| | \ | | \ \   / /                                     ";
echo "              |  _|   |  \| |  \ \ / /                                      ";
echo "              | |___  | |\  |   \ V /                                       ";
echo "              |_____| |_| \_|    \_/                                        ";
echo "                                                                            ";
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}System Environment Configuration${reset}                    "
echo "----------------------------------------------------------------------------"
echo ""

# Make Floder
if [ ! -d "$HOME/Workspace" ]; then mkdir -p "$HOME/Workspace"; fi
if [ ! -d "$HOME/Desktop" ]; then mkdir -p "$HOME/Desktop"; fi

# Set Xrdb
if [ ! "$XDG_VTNR" = "" ]; then
    xrdb $HOME/.Xresources 
fi

echo -e "\t\t[+]${green}Set Xterm of Xrdb Successful${reset}\n"

# Set Locales Language
# sudo dpkg-reconfigure locales
sudo locale-gen "zh_CN.UTF-8" > /dev/null 2>&1
sudo dpkg-reconfigure --frontend=noninteractive locales > /dev/null 2>&1
echo -e "\t\t[+]${green}Set Locales Language is Successful${reset}\n"

# Set TimeZone
sudo timedatectl set-timezone "Asia/Shanghai"
echo -e "\t\t[+]${green}Set TimeZone is Successful${reset}\n"

# Set Add Hosts Speed Sudo 
if [ -f "/etc/hosts" ]; then
    sudo bash -c "echo -e '127.0.0.1\t$HOSTNAME' >> /etc/hosts"
fi

echo -e "\t\t[+]${green}Set Add Hosts is Successful${reset}\n"
}


#----------------------------------------------------------------------------------------#
# Repace Sources and System Update & Upgrade Packages
#----------------------------------------------------------------------------------------#

sysUpdate(){

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";         
echo "               ____            _                                            ";
echo "              / ___| _   _ ___| |_ ___ _ __ ___                             ";
echo "              \___ \| | | / __| __/ _ \ '_    _ \                           ";
echo "               ___) | |_| \__ \ ||  __/ | | | | |                           ";
echo "              |____/ \__, |___/\__\___|_| |_| |_|                           ";
echo "                     |___/                                                  ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Repace Sources and System Update & Upgrade Packages${reset} "
echo "----------------------------------------------------------------------------"
echo ""

sudo ln -sf "$Dotfiles_repo/sources.list" "/etc/apt/sources.list"
echo -e "\t\t${green}[+]Repace sources.list Done !${reset}\n"
sudo apt update -y -qq > /dev/null 2>&1
echo -e "\t\t${green}[+]Update Successful !${reset}\n"
sudo apt upgrade -y -qq > /dev/null 2>&1
echo -e "\t\t${green}[+]Upgrade Successful !${reset}\n"
}

#----------------------------------------------------------------------------------------#
# Apt - Install
#----------------------------------------------------------------------------------------#

aptInstall() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "                  _      ____    _____                                      ";
echo "                 / \    |  _ \  |_   _|                                     ";
echo "                / _ \   | |_) |   | |                                       ";
echo "               / ___ \  |  __/    | |                                       ";
echo "              /_/   \_\ |_|       |_|                                       ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Apt - Install${reset}                                       "
echo "----------------------------------------------------------------------------"
echo ""

	aptApps=(\
        wget\
        git\
        python3-pip\
        python-pip\
        curl\
        ctags\
        vim\
        tmux\
        silversearcher-ag\
        w3m\
        unzip\
        ranger\
        xclip\
        inotify-tools\
        zlib1g-dev\
        ruby-full\
        xvfb\
        xserver-xorg\
        dbus-x11\
        xinit\
        language-pack-zh-hans\
        fonts-wqy-microhei\
        fcitx\
        fcitx-pinyin\
        i3\
        rofi\
        feh\
        compton\
        i3status\
        i3lock-fancy\
        zathura\
        i3blocks\
        xinput\
        open-vm-tools\
        open-vm-tools-desktop\
        calibre\
        deepin-screenshot\
        openssh-server\
        openssh-client
        )
	for app in "${aptApps[@]}"
	do
		echo -e "\t\t[*] Installing: $app";
		sudo apt install -y -qq $app > /dev/null 2>&1
		installSuccess $? $app
	done
}

#----------------------------------------------------------------------------------------#
# Pip3 - Install
#----------------------------------------------------------------------------------------#

pipInstall() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "               ____    ___   ____    _____                                  ";
echo "              |  _ \  |_ _| |  _ \  |___ /                                  ";
echo "              | |_) |  | |  | |_) |   |_ \                                  ";
echo "              |  __/   | |  |  __/   ___) |                                 ";
echo "              |_|     |___| |_|     |____/                                  ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}PIP3 - Install${reset}                                      "
echo "----------------------------------------------------------------------------"
echo ""

	pipApps=(\
        powerline-shell\
        pandas\
        django\
        pyvirtualdisplay\
        selenium
        )
	for app in "${pipApps[@]}"
	do
		echo -e "\t\t[*] Installing: $app";
		sudo pip3 install -q --timeout 1000 $app -i https://pypi.tuna.tsinghua.edu.cn/simple/ > /dev/null 2>&1
		installSuccess $? $app
	done
}

#----------------------------------------------------------------------------------------#
# Gem - Install
#----------------------------------------------------------------------------------------#

gemInstall() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "                ____   _____   __  __                                       ";
echo "               / ___| | ____| |  \/  |                                      ";
echo "              | |  _  |  _|   | |\/| |                                      ";
echo "              | |_| | | |___  | |  | |                                      ";
echo "               \____| |_____| |_|  |_|                                      ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}GEM - Install${reset}                                       "
echo "----------------------------------------------------------------------------"
echo ""

	gemApps=(\
        vimwiki_markdown
        )
	for app in "${gemApps[@]}"
	do
		echo -e "\t\t[*] Installing: $app";
		sudo gem install $app > /dev/null 2>&1
		installSuccess $? $app
	done
}

#----------------------------------------------------------------------------------------#
# Local - Install & Config
#----------------------------------------------------------------------------------------#

LocalDpkg() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "               _                    _                                       ";
echo "              | |    ___   ___ __ _| |                                      ";
echo "              | |   / _ \ / __/ _  | |                                      ";
echo "              | |__| (_) | (_| (_| | |                                      ";
echo "              |_____\___/ \___\__,_|_|  - Dpkg Install                      ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Local - Install ${reset}                                    "
echo "----------------------------------------------------------------------------"
echo ""

	dpkgApps=(\
        ripgrep.deb\
        fd.deb\
        bat.deb\
        Alacritty.deb\
        bat.deb
        )
	for app in "${dpkgApps[@]}"
	do
		echo -e "\t\t[*] Installing: $app";
		sudo dpkg -i $Dotfiles_repo/bin/$app > /dev/null 2>&1
		installSuccess $? $app
	done
}

LoaclConfig() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "               _                    _                                       ";
echo "              | |    ___   ___ __ _| |                                      ";
echo "              | |   / _ \ / __/ _  | |                                      ";
echo "              | |__| (_) | (_| (_| | |                                      ";
echo "              |_____\___/ \___\__,_|_|  - Config and Settings               ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Local - Config and Settings ${reset}                        "
echo "----------------------------------------------------------------------------"
echo ""

#----------------------------------------------------------------------------------------#
# Fcitx 
#----------------------------------------------------------------------------------------#

        im-config -n fcitx > /dev/null 2>&1
        im-config -s fcitx > /dev/null 2>&1
        echo -e "\t\t[√]${green} Fcitx Successful${reset}\n"

#----------------------------------------------------------------------------------------#
# TLDR 
#----------------------------------------------------------------------------------------#

        if [ ! -f "/bin/tldr" ];then
            sudo cp $Dotfiles_repo/bin/tldr /bin
            sudo chmod +x /bin/tldr
        else
            sudo rm -rf /bin/tldr
            sudo cp $Dotfiles_repo/bin/tldr /bin
            sudo chmod +x /bin/tldr
        fi
        echo -e "\t\t[√]${green} TLDR Successful${reset}\n"


#----------------------------------------------------------------------------------------#
# Chrome 
#----------------------------------------------------------------------------------------#

        # Install Chrome
        sudo wget -q -t 0 -P $HOME https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo dpkg -i $HOME/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo apt --fix-broken install -y -qq > /dev/null 2>&1
        sudo dpkg -i $Dotfiles_repo/chrome/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo rm -rf $HOME/google*
        echo -e "\t\t[√]${green} Chrome Successful${reset}\n"
        
        # Install ChromeDriver
        if [ -f "/usr/local/share/chromedriver" ]; then
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
        echo -e "\t\t[√]${green} ChromeDriver Successful${reset}\n"

        # Unzip Chrome Plugin
        if [ ! -d "$HOME/chrome-extend" ]; then
            env mkdir $HOME/chrome-extend
        else
            rm -rf $HOME/chrome-extend
            env mkdir $HOME/chrome-extend
        fi
        unzip -q $Dotfiles_repo/chrome/darkreader.zip -d $HOME/chrome-extend
        unzip -q $Dotfiles_repo/chrome/vimium.zip -d $HOME/chrome-extend
        unzip -q $Dotfiles_repo/chrome/proxyswitch.zip -d $HOME/chrome-extend
        echo -e "\t\t[√]${green} Unzip ChromeExtend-Pack Successful${reset}\n"

#----------------------------------------------------------------------------------------#
# Tmux
#----------------------------------------------------------------------------------------#

        if [ ! -d "$HOME/.tmux" ]; then
            git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
        else
            sudo rm -rf $HOME/.tmux
            git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
        fi
        tmux start-server
        tmux new-session -d
        $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
        tmux kill-server
        echo -e "\t\t[√]${green} Tmux Successful${reset}\n"

#----------------------------------------------------------------------------------------#
# diff-so-fancy
#----------------------------------------------------------------------------------------#

        if [ ! -f "/usr/local/bin/diff-so-fancy" ]; then
            sudo cp -f $Dotfiles_repo/bin/diff-so-fancy /usr/local/bin
            sudo chmod 777 /usr/local/bin/diff-so-fancy
        else
            sudo rm -rf /usr/local/bin/diff-so-fancy
            sudo cp -f $Dotfiles_repo/bin/diff-so-fancy /usr/local/bin
            sudo chmod 777 /usr/local/bin/diff-so-fancy
        fi
        echo -e "\t\t[√]${green} Diff-So-Fancy Successful${reset}\n"

#----------------------------------------------------------------------------------------#
# Install Vim Plug
#----------------------------------------------------------------------------------------#

        vim
        echo -e "\t\t[√]${green} Vim Successful${reset}\n"

}

#----------------------------------------------------------------------------------------#
# Install - Fonts
#----------------------------------------------------------------------------------------#

installFonts() {

echo ""
echo "----------------------------------------------------------------------------"
echo "                                                                            ";           
echo "               _____           _                                            ";
echo "              |  ___|__  _ __ | |_ ___                                      ";
echo "              | |_ / _ \| '_ \| __/ __|                                     ";
echo "              |  _| (_) | | | | |_\__ \                                     ";
echo "              |_|  \___/|_| |_|\__|___/   - Install                         ";
echo "                                                                            ";           
echo "----------------------------------------------------------------------------"
echo -e " \t\t ${blue}Fonts Install ${reset}                                      "
echo "----------------------------------------------------------------------------"
echo ""

        if [ ! -d "$HOME/Fonts" ]; then
            git clone --depth=1 -q\
                https://github.com/hantaotaohan/Fonts_minimize.git\
                $HOME/Desktop/Fonts && cd $Powerlinefont_dir && ./install.sh
        else
            cd $HOME/Fonts &&\
            git reset --hard && git pull -q && ./install.sh
        fi
}

#----------------------------------------------------------------------------------------#
# Install - Status
#----------------------------------------------------------------------------------------#

installSuccess() {
	if [ $1 -eq 0 ]; then
            echo -e "\t\t${green}[√] Install Success: $2${reset}\n"
	else
    		echo -e "\t\t${red}[X] Install Failed: $2${reset}\n"
	fi
}


#----------------------------------------------------------------------------------------#
# Sync & Update - Dotfiles
#----------------------------------------------------------------------------------------#

Sync_Dotfiles() {
    git reset -q --hard && git pull -q
    echo -e "${green}● ۞ Update Complete ${reset}"
}

#----------------------------------------------------------------------------------------#
# Running Bash in Install.sh
#----------------------------------------------------------------------------------------#

main() {

#----------------------------------------------------------------------------------------#
# Auto Sync Dotfiles 
#----------------------------------------------------------------------------------------#

    Sync_Dotfiles

    echo "                                                                            "
    echo "----------------------------------------------------------------------------"
    echo "                                                                            "
    echo " -h        Print this message                                               "
    echo "                                                                            "
    echo " -A        Install All                                                      "
    echo " -D        Install Dotfiles & Enviroment                                    "
    echo " -S        Update System & Setup Alls Tools & Enviroment                    "
    echo "                                                                            "
    echo "----------------------------------------------------------------------------"
    echo "                                                                            "
    echo " -1        Install Dotfiles                                                 "
    echo " -2        Uninstall Dotfiles                                               "
    echo " -3        Install Environment                                              "
    echo " -4        Install APT Tools                                                "
    echo " -5        Install PIP3 Tools                                               "
    echo " -6        Install GEM Tools                                                "
    echo " -7        Install Local Bin Folder Tools                                   "
    echo " -8        Install Fonts                                                    "
    echo "                                                                            "
    echo " -q        Exit                                                             "
    echo "                                                                            "
    echo "----------------------------------------------------------------------------"
    echo "                                                                            "

    read -r -p "Please select the mode you want to install ?  " input

    case "$input" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -[aA])
            install_dotfiles
            workspace_settings
            sysUpdate
	        aptInstall
	        pipInstall
            gemInstall
            LocalDpkg
            LoaclConfig
            installFonts
            sudo apt autoremove -y -qq > /dev/null 2>&1
            echo -e "\t\t[√]${green} *** All Install Successful *** ${reset}\n"
            bash
            ;;
        -[dD])
            install_dotfiles
            workspace_settings
            bash
            ;;
        -[sS])
            sysUpdate
	        aptInstall
	        pipInstall
            gemInstall
            LocalDpkg
            LoaclConfig
            sudo apt autoremove -y -qq > /dev/null 2>&1
            echo -e "\t[√]${green} *** All Install Successful *** ${reset}\n"
            bash
            ;;
        -1)
            install_dotfiles
            bash
            ;;
        -2)
            uninstall_dotfiles
            bash
            ;;
        -3)
            workspace_settings
            bash
            ;;
        -4)
	        aptInstall
            bash
            ;;
        -5)
	        pipInstall
            bash
            ;;
        -6)
            gemInstall
            bash
            ;;
        -7)
            LocalDpkg
            LoaclConfig
            bash
            ;;
        -8)
            installFonts
            bash
            ;;
        [qQ]) 
            exit; break 
            ;;
        *)
            echo -e"\nCommand not found" >&2
            exit 1
    esac
}

main "$@"
