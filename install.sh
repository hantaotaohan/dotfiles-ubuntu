#!/usr/bin/env bash

clear

#===================================================================
# Start
#===================================================================

echo ""
echo "                                                                   ";
echo "               ___  _   _  ____   _____     _     _      _         ";
echo "              |_ _|| \ | |/ ___| |_   _|   / \   | |    | |        ";
echo "               | | |  \| |\___ \   | |    / _ \  | |    | |        ";
echo "               | | | |\  | ___) |  | |   / ___ \ | |___ | |___     ";
echo "              |___||_| \_||____/   |_|  /_/   \_\|_____||_____|    ";
echo "                                                                   ";                                                                                    
echo ""
echo "--------------------------------------------------------------------"
echo -e " \t\tTaoTao - Saber - Ubuntu - Desktop - Install                 "
echo "--------------------------------------------------------------------"
echo ""

#===================================================================
# Setting Colors
#===================================================================

red='\e[1;31m'
blue='\e[0;34m'
green='\e[0;32m'
white='\e[0;37m'
reset='\e[0;37m'

#===================================================================
# Setting Variable
#===================================================================

Backup_dir="$HOME/.dotfiles.orig"
#Dotfiles_repo=$(dirname $PWD)
Dotfiles_repo=$(pwd)

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

#===================================================================
# Print usage message.
#===================================================================

usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
    Usage: $program_name [-option]
    Options:
    --help    Print this message
    -d        Install all config
    -r        Restore old config
    -s        Install System 
    -f        Install Fonts 
    -a        Install All's
EOF
}


#===================================================================
# Install Dotfiles 
#===================================================================

install_dotfiles() {
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
    echo "Please read carefully the error messages and make sure all packages are installed. See more info in README.md." >&2
    echo "Note that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "If you want to restore your old config, you can use ${red}./install.sh -r${white} command." >&2
}


#===================================================================
# Workspace Settings
#===================================================================

workspace_settings() {
# Make Floder
mkdir $HOME/Workspace
mkdir $HOME/Desktop

# Set Xrdb
if [ ! "$XDG_VTNR" = "" ]; then
    xrdb $HOME/.Xresources 
fi

echo -e "\t[+]${green}Set Xterm of Xrdb Successful\n"

# Set Locales Language
# sudo dpkg-reconfigure locales
sudo locale-gen "zh_CN.UTF-8" > /dev/null 2>&1
sudo dpkg-reconfigure --frontend=noninteractive locales > /dev/null 2>&1
echo -e "\t[+]${green}Set Locales Language is Successful\n"

# Set TimeZone
sudo timedatectl set-timezone "Asia/Shanghai"
echo -e "\t[+]${green}Set TimeZone is Successful\n"

# Set Add Hosts Speed Sudo 
if [ -f "/etc/hosts" ]; then
    sudo bash -c "echo -e '127.0.0.1\t$HOSTNAME' >> /etc/hosts"
fi

echo -e "\t[+]${green}Set Add Hosts is Successful\n"
}

#===================================================================
# Uninstall Dotfiles
#===================================================================

uninstall_dotfiles() {
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


#===================================================================
# Repace Sources and System Update & Upgrade Packages
#===================================================================

sysUpdate(){
sudo ln -sf "$Dotfiles_repo/sources.list" "/etc/apt/sources.list"
echo -e "\t${green}[+]Repace sources.list Done !${reset}"
sudo apt update -y -qq > /dev/null 2>&1
echo -e "\t${green}[+]Update Successful !${reset}"
sudo apt upgrade -y -qq > /dev/null 2>&1
echo -e "\t${green}[+]Upgrade Successful !${reset}"
}

#===================================================================
# Apt - Install
#===================================================================

aptInstall() {
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
		echo "[*] Installing: $app";
		sudo apt install -y -qq $app > /dev/null 2>&1
		installSuccess $? $app
	done
}

#===================================================================
# Pip3 - Install
#===================================================================

pipInstall() {
	pipApps=(\
        powerline-shell\
        pandas\
        django\
        pyvirtualdisplay\
        selenium
        )
	for app in "${pipApps[@]}"
	do
		echo "[*] Installing: $app";
		sudo pip3 install -q --timeout 1000 $app -i https://pypi.tuna.tsinghua.edu.cn/simple/ > /dev/null 2>&1
		installSuccess $? $app
	done
}

#===================================================================
# Gem - Install
#===================================================================

gemInstall() {
	gemApps=(\
        vimwiki_markdown
        )
	for app in "${gemApps[@]}"
	do
		echo "[*] Installing: $app";
		sudo gem install $app > /dev/null 2>&1
		installSuccess $? $app
	done
}

#===================================================================
# Local - Install & Config
#===================================================================

LocalDpkg() {
	dpkgApps=(\
        ripgrep.deb\
        fd.deb\
        bat.deb\
        Alacritty.deb\
        bat.deb
        )
	for app in "${dpkgApps[@]}"
	do
		echo "[*] Installing: $app";
		sudo dpkg -i $Dotfiles_repo/bin/$app > /dev/null 2>&1
		installSuccess $? $app
	done
}

LoaclConfig() {

#-------------------------------------------------------------------
# TLDR 
#-------------------------------------------------------------------

        im-config -n fcitx > /dev/null 2>&1
        im-config -s fcitx > /dev/null 2>&1
        echo -e "\t[√]${green} Fcitx Successful${reset}\n"

#-------------------------------------------------------------------
# TLDR 
#-------------------------------------------------------------------

        if [ ! -f "/bin/tldr" ];then
            sudo cp $Dotfiles_repo/bin/tldr /bin
            sudo chmod +x $HOME/bin/tldr
        else
            sudo rm -rf /bin/tldr
            sudo cp $Dotfiles_repo/bin/tldr /bin
            sudo chmod +x $HOME/bin/tldr
        fi
        echo -e "\t[√]${green} TLDR Successful${reset}\n"


#-------------------------------------------------------------------
# Chrome 
#-------------------------------------------------------------------

        # Install Chrome
        sudo wget -q -t 0 -P $HOME https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo dpkg -i $HOME/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo apt --fix-broken install -y -qq > /dev/null 2>&1
        sudo dpkg -i $Dotfiles_repo/chrome/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
        sudo rm -rf $HOME/google*
        echo -e "\t[√]${green} Chrome Successful${reset}\n"
        
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
        echo -e "\t[√]${green} ChromeDriver Successful${reset}\n"

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
        echo -e "\t[√]${green} Unzip ChromeExtend-Pack Successful${reset}\n"

#-------------------------------------------------------------------
# Tmux
#-------------------------------------------------------------------

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
        echo -e "\t[√]${green} Tmux Successful${reset}\n"

#-------------------------------------------------------------------
# diff-so-fancy
#-------------------------------------------------------------------

        if [ ! -f "/usr/local/bin/diff-so-fancy" ]; then
            sudo cp -f $Dotfiles_repo/bin/diff-so-fancy /usr/local/bin
            sudo chmod 777 /usr/local/bin/diff-so-fancy
        else
            sudo rm -rf /usr/local/bin/diff-so-fancy
            sudo cp -f $Dotfiles_repo/bin/diff-so-fancy /usr/local/bin
            sudo chmod 777 /usr/local/bin/diff-so-fancy
        fi
        echo -e "\t[√]${green} Diff-So-Fancy Successful${reset}\n"

#-------------------------------------------------------------------
# Install Vim Plug
#-------------------------------------------------------------------

        vim
        echo -e "\t[√]${green} Vim Successful${reset}\n"

}

#===================================================================
# Install - Fonts
#===================================================================

installFonts() {
        prefix="$1"
        font_dir="$HOME/.local/share/fonts"
        powerline_fonts_dir="$HOME/Fonts"
        
        if [ ! -d "$font_dir" ]; then sudo mkdir -p "$font_dir"; fi
        if [ ! -d "$powerline_font_dir" ]; then env mkdir -p "$font_dir"; fi
        
        wget --no-check-certificate -t 0 -q --show-progress -P $HOME/ https://github.com/hantaotaohan/Fonts/releases/download/1.0/Fonts.zip &&\
        unzip -q $HOME/Fonts.zip -d $powerline_font_dir/ &&\
        find "$powerline_fonts_dir" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"
        
        if which fc-cache >/dev/null 2>&1 ; then
            echo -e "\t[*]${green} Resetting font cache, this may take a moment...${reset}\n"
            fc-cache -f "$font_dir"
            echo -e "\t[√]${green} Fonts Install Successful${reset}\n"
        fi

}
#===================================================================
# Install - Status
#===================================================================

installSuccess() {
	if [ $1 -eq 0 ]; then
            echo -e "${green}[√] Install Success: $2${reset}\n"
	else
    		echo -e "${red}[X] Install Failed: $2${reset}\n"
	fi
}

#===================================================================
# Running Bash in Install.sh
#===================================================================

main() {
    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -d)
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${green}[#] Install Dotfiles${reset}"
            echo "--------------------------------------------------------------------"
            install_dotfiles
            workspace_settings
            bash
            ;;
        -r)
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${red}[#] Uninstall Dotfiles${reset}"
            echo "--------------------------------------------------------------------"
            uninstall_dotfiles
            bash
            ;;
        -s)
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] System Update${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            sysUpdate

            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Advanced Packaging Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
	        aptInstall

            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Python3 Installing Packages'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
	        pipInstall

            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'RubyGems Installing Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            gemInstall

            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Local DPKG Installing Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            LocalDpkg

            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Setting Tools Config ${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            LoaclConfig

            sudo apt autoremove -y -qq > /dev/null 2>&1
            echo -e "\t[√]${green} *** All Install Successful *** ${reset}\n"
            bash
            ;;
        -f)
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${red}[#] Install Fonts${reset}"
            echo "--------------------------------------------------------------------"
            installFonts
            bash
            ;;
        -a)
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${green}[#] Install Dotfiles${reset}"
            echo "--------------------------------------------------------------------"
            install_dotfiles
            workspace_settings
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] System Update${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            sysUpdate
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Advanced Packaging Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
	        aptInstall
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Python3 Installing Packages'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
	        pipInstall
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'RubyGems Installing Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            gemInstall
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Installing 'Local DPKG Installing Tool'${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            LocalDpkg
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${blue}[#] Setting Tools Config ${reset}"
            echo "--------------------------------------------------------------------"
            echo ""
            LoaclConfig
            echo "--------------------------------------------------------------------"
            echo -e "\t\t${red}[#] Install Fonts${reset}"
            echo "--------------------------------------------------------------------"
            installFonts
            sudo apt autoremove -y -qq > /dev/null 2>&1
            echo -e "\t[√]${green} *** All Install Successful *** ${reset}\n"
            bash
            ;;
        *)
            echo "Command not found" >&2
            exit 1
    esac
}

main "$@"
