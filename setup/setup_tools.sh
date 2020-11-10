#!/usr/bin/env bash

# Print usage message.
usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]
Options:
    
    --help    Print this message
    
    -all      Install All tools

    -1        Install Alttab
    -2        Install Arcthemes
    -3        Install Arcicons
    -4        Install Copytranslator
    -5        Install Crossover
    -6        Install I3gaps
    -7        Install Imagemagick
    -8        Install Jupyter Themes
    -9        Install Navi
    -10       Install Peek
    -11       Install Picom
    -12       Install SSR
    -13       Install Dunst
    -14       Install VIM
    -15       Auto run Offlineimap
    -16       Config Dark Fcitx
    -17       Config GTK Suppor Ctrlc.v
    -18       Config Github SSHkey
    -19       Config Hosts Suppor Github_Hosts
    -20       Config I3_Sensible_Terminal Default
    -21       Fix VMware Share Floader
    -22       Install Calibre
    -23       Install Foliate
EOF
}

row() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

Alttab() {
    sudo apt install -y libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm4 libxpm-dev
    wget -P $HOME/Desktop https://download.fastgit.org/sagb/alttab/archive/v1.5.0.zip
    cd $HOME/Desktop && unzip v1.5.0.zip && cd alttab-1.5.0
    ./configure 
    make 
    sudo make install 
    sudo rm -rf $HOME/Desktop/alttab-1.5.0
    row
}

Arcthemes() {
    sudo apt install -y arc-theme
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
    fi
    row
}

Arcicons() {
    git clone https://hub.fastgit.org/horst3180/arc-icon-theme --depth 1 $HOME/Desktop/arc-icon-theme && cd $HOME/Desktop/arc-icon-theme
    sudo cp -r Arc /usr/share/icons/
    sudo chmod +x /usr/share/icons/Arc
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-icon-theme-name = ubuntu-mono-dark/gtk-icon-theme-name = Arc/g' /etc/gtk-3.0/settings.ini
    fi
    cd $HOME
    sudo rm -rf $HOME/Desktop/arc-icon-theme
    row
}

Copytranslator() {
    wget -P $HOME/Desktop https://download.fastgit.org/CopyTranslator/CopyTranslator/releases/download/v10.0.0-beta.2/copytranslator_10.0.0-beta.2_amd64.deb
    cd $HOME/Desktop
    sudo dpkg -i copytranslator_10.0.0-beta.2_amd64.deb
    sudo chown -R taotao:taotao /dev/input/mice
    cd $HOME
    sudo rm -rf $HOME/Desktop/copytranslator_10.0.0-beta.2_amd64.deb
    row
}

Crossover() {
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/crossover-20.deb
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/winewrapper.exe.so
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/KindleforPC_v1.21.48019.exe
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/kindle_exe.zip
    sudo dpkg -i $HOME/Desktop/crossover-20.deb
    sudo apt install -f -y
    sudo dpkg -i $HOME/Desktop/crossover-20.deb
    sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
    sudo cp $HOME/Desktop/winewrapper.exe.so /opt/cxoffice/lib/wine/
    cd $HOME
    sudo rm -rf $HOME/Desktop/winewrapper.exe.so crossover-20.deb
    row
}

I3gaps() {
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt-get update
    sudo apt install -y i3-gaps-wm
    sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove ppa:kgilmer/speed-ricer
    sed -i 's|# smart_gaps on|smart_gaps on|g' $HOME/.config/i3/config
    sed -i 's|# gaps inner 8|gaps inner 8|g' $HOME/.config/i3/config
    sed -i 's|# gaps outer 2|gaps outer 2|g' $HOME/.config/i3/config
    row
}

Imagemagick() {
    sudo apt install -y imagemagick
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi
    row
}

Jupyter() {
    sudo pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1
    if [ ! -d "$HOME/.jupyter/custom/" ]
    then
        mkdir -p $HOME/.jupyter/custom/
        cp $HOME/Dotfiles/setup/jupyter/custom.css $HOME/.jupyter/custom/custom.css
    fi

    if [ ! -d "$HOME/.ipython/profile_default/startup/" ]
    then
        mkdir -p $HOME/.ipython/profile_default/startup/
        cp $HOME/Dotfiles/setup/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
    fi
    row
}

Navi() {
    sudo bash -c "$(wget -O- https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        ln -fs $HOME/Dotfiles/setup/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        ln -fs $HOME/Dotfiles/setup/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
    row
}

Peek() {
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt update
    sudo apt install -y peek
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove peek-developers/stable
    row
}

Picom() {
    sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
    sudo apt install -y meson
    git clone https://hub.fastgit.org/yshui/picom.git $HOME/Desktop/picom && \
    cd $HOME/Desktop/picom && \
    git submodule update --init --recursive && \
    meson --buildtype=release . build && \
    sudo ninja -C build && \
    sudo ninja -C build install && \
    cd $HOME
    sudo rm -rf $HOME/Desktop/picom
    sed -i "s|# exec --no-startup-id picom --config ~/.config/picom/picom.conf|exec --no-startup-id picom --config ~/.config/picom/picom.conf|g" $HOME/.config/i3/config
    sed -i "s|exec --no-startup-id compton --config ~/.config/compton/compton.conf|# exec --no-startup-id compton --config ~/.config/compton/compton.conf|g" $HOME/.config/i3/config
    row
}

SSR() {
    wget -P $HOME/Desktop https://download.fastgit.org/shadowsocksrr/electron-ssr/releases/download/0.3.0-alpha.6/electron-ssr-0.3.0-alpha.6.deb
    sudo dpkg -i $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
    sudo apt install -f -y
    sudo dpkg -i $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
    cd $HOME
    sudo rm -rf $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
    row
}

Dunst() {
    sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
    git clone https://hub.fastgit.org/dunst-project/dunst.git $HOME/Desktop/dunst
    cd $HOME/Desktop/dunst
    make
    sudo make install
    cd $HOME
    rm -rf $HOME/Desktop/dunst
    row
}

VIM() {
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt update
    sudo apt install -y vim
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove ppa:jonathonf/vim
    row
}



Offlineimap() {
    sudo cp /usr/share/doc/offlineimap/examples/systemd/offlineimap.service /etc/systemd/user
    systemctl --user enable offlineimap
    systemctl --user start offlineimap
    row
}

Fcitx() {
    if [ -f $HOME/.config/fcitx/conf/fcitx-classic-ui.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-classic-ui.config
        sudo cp $HOME/Dotfiles/setup/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    else
        sudo cp $HOME/Dotfiles/setup/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    fi
    row
}

GTK() {
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo cp $HOME/Dotfiles/setup/gtk3setting/settings.ini /etc/gtk-3.0/settings.ini
    fi
    row
}

Github() {
    if ! [ -f $HOME/.ssh/id_rsa.pub ]; then
        echo 'Email for ssh key'
        read -e ssh_email
        ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa
        echo 'Key copied to keyboard'
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        google-chrome --new-window 'https://github.com/settings/keys'
    fi
    row
}

Github_Hosts() {
    sudo python3 $HOME/Dotfiles/setup/github_hosts.py
    row
}

I3_Sensible_Terminal() {
    if [ -f /usr/bin/i3-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/rofi-sensible-terminal
    fi
    if [ -f /usr/bin/rofi-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/i3-sensible-terminal
    fi
    row
}

Vmware_Share_Fix() {
    if type vmhgfs-fuse >/dev/null 2>&1; then
        sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other,nonempty ;
    fi
}

Calibre() {
    sudo apt install calibre
    sudo snap install foliate
    git clone https://github.com/hantaotaohan/CalibreLibrary $HOME/CalibreLibrary
}

Foliate() {
    sudo snap install foliate
}

main() {

    echo "                                                                               "
    echo "-------------------------------------------------------------------------------"
    echo "                                                                               "
    echo " -h        Print this message                                                  "
    echo "                                                                               "
    echo " -a        Setup All                                                           "
    echo "                                                                               "
    echo "-------------------------------------------------------------------------------"
    echo "                                                                               "
    echo " -1        Setup Alttab                                                        "
    echo " -2        Setup Arc-themes                                                    "
    echo " -3        Setup Arc-icons                                                     "
    echo " -4        Setup Copytranslator                                                "
    echo " -5        Setup Crossover & Kindle                                            "
    echo " -6        Setup I3gaps                                                        "
    echo " -7        Setup Imagemagick                                                   "
    echo " -8        Setup Jupyter Themes                                                "
    echo " -9        Setup Navi                                                          "
    echo " -10       Setup Peek                                                          "
    echo " -11       Setup Picom                                                         "
    echo " -12       Setup SSR Tools                                                     "
    echo " -13       Update Dunst                                                        "
    echo " -14       Update VIM with PPA                                                 "
    echo " -15       Auto Start Run Offlineimap                                          "
    echo " -16       Config Fcitx                                                        "
    echo " -17       Config GTK with Ctrl+xcv                                            "
    echo " -18       Config Github SSH                                                   "
    echo " -19       Config Github_Hosts > Hosts                                         "
    echo " -20       Config I3wm - Defaul - I3_Sensible_Terminal - Fix                   "
    echo " -21       Fix VMware Share Floader                                            "
    echo " -22       Setup Calibre                                                       "
    echo " -23       Setup Foliate                                                       "
    echo "                                                                               "
    echo "-------------------------------------------------------------------------------"
    echo "                                                                               "
    echo " -q        Exit                                                                "
    echo "                                                                               "
    echo "-------------------------------------------------------------------------------"
    echo "                                                                               "

    read -r -p "Please select the mode you want to install ?  " input

    case "$input" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -1)
            Alttab
            ;;
        -2)
            Arcthemes
            ;;
        -3)
            Arcicons
            ;;
        -4)
            Copytranslator
            ;;
        -5)
            Crossover
            ;;
        -6)
            I3gaps
            ;;
        -7)
            Imagemagick
            ;;
        -8)
            Jupyter
            ;;
        -9)
            Navi
            ;;
        -10)
            Peek
            ;;
        -11)
            Picom
            ;;
        -12)
            SSR
            ;;
        -13)
            Dunst
            ;;
        -14)
            VIM
            ;;
        -15)
            Offlineimap
            ;;
        -16)
            Fcitx
            ;;
        -17)
            GTK
            ;;
        -18)
            Github
            ;;
        -19)
            Github_Hosts
            ;;
        -20)
            I3_Sensible_Terminal
            ;;
        -21)
            Vmware_Share_Fix
            ;;
        -22)
            Calibre
            ;;
        -23)
            Foliate
            ;;
        -[aA])
            Github_Hosts
            Dunst
            VIM
            I3gaps
            Arcthemes
            Arcicons
            GTK
            Imagemagick
            Jupyter
            Navi
            Peek
            Fcitx
            I3_Sensible_Terminal
            Offlineimap
            Alttab
            # Copytranslator
            # Crossover
            # Picom
            # SSR
            # Github
            ;;
        -[qQ]) 
            exit; break 
            ;;
        *)
            echo "Command not found" >&2
            exit 1
    esac
}

main "$@"

