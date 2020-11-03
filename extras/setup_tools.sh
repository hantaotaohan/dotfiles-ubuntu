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

    -1        Alttab
    -2        Arcthemes
    -3        Arcicons
    -4        Alttab
    -5        Copytranslator
    -6        Crossover
    -7        I3gaps
    -8        Imagemagick
    -9        Jupyter
    -10       Navi
    -11       Peek
    -12       Picom
    -13       SSR
    -14       Dunst
    -15       VIM
    -16       Offlineimap
    -17       Fcitx
    -18       GTK
    -19       Github
    -20       Github_Hosts
    -21       I3_Sensible_Terminal
EOF
}

row() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

Alttab() {
    if [ -d $HOME/Desktop/alttab  ]; then
        rm -rf $HOME/Desktop/alttab
        sudo apt install -y libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm4 libxpm-dev
        git clone https://github.com/sagb/alttab.git $HOME/Desktop/alttab 
        cd $HOME/Desktop/alttab || return
        ./configure && \
        make && \
        sudo make install && \
        cd $HOME || return
        sudo rm -rf $HOME/Desktop/alttab
        row
    else
        sudo apt install -y libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm4 libxpm-dev
        git clone https://github.com/sagb/alttab.git $HOME/Desktop/alttab 
        cd $HOME/Desktop/alttab || return
        ./configure && \
        make && \
        sudo make install && \
        cd $HOME || return
        sudo rm -rf $HOME/Desktop/alttab
        row
    fi
}


Arcthemes() {
    sudo apt install -y arc-theme
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
    fi
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
}

Copytranslator() {
    wget -P $HOME/Desktop https://download.fastgit.org/CopyTranslator/CopyTranslator/releases/download/v10.0.0-beta.2/copytranslator_10.0.0-beta.2_amd64.deb
    sudo dpkg -i copytranslator_10.0.0-beta.2_amd64.deb
    cd $HOME
    sudo rm -rf $HOME/Desktop/copytranslator_10.0.0-beta.2_amd64.deb
}

Crossover() {
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/crossover-20.deb
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/winewrapper.exe.so
    wget -P $HOME/Desktop/ https://download.fastgit.org/hantaotaohan/Dotfiles/releases/download/1.0.3/KindleForPC-installer-1.16.44025.exe
    sudo dpkg -i $HOME/Desktop/crossover-20.deb
    sudo apt install -f -y
    sudo dpkg -i $HOME/Desktop/crossover-20.deb
    sudo sh -c "apt-get update; echo -n Waiting for the dpkg lock; while fuser /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/run/unattended-upgrades.lock >/dev/null 2>&1; do echo -n .; sleep 1; done; env DEBIAN_FRONTEND=noninteractive apt-get install -y gstreamer1.0-plugins-base:i386 gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-ugly:i386 libc6-i386 libcups2:i386 libdbus-1-3:i386 libfontconfig1:i386 libfreetype6:i386 libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libglu1-mesa:amd64 libglu1-mesa:i386 libgnutls30:i386 libgstreamer1.0-0:i386 libldap-2.4-2:i386 libpng16-16:i386 libsane:amd64 libsane:i386 libudev1:i386 libvulkan1:i386 libx11-6:i386 libxcomposite1:i386 libxcursor1:i386 libxext6:i386 libxfixes3:i386 libxi6:i386 libxinerama1:i386 libxml2:i386 libxrandr2:i386 libxrender1:i386 libxslt1.1:i386 libxxf86vm1:i386"
    sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
    sudo cp $HOME/Desktop/winewrapper.exe.so /opt/cxoffice/lib/wine/
    cd $HOME
    sudo rm -rf $HOME/Desktop/winewrapper.exe.so crossover-20.deb
}

I3gaps() {
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer
    sudo apt-get update
    sudo apt install -y i3-gaps-wm
    sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
    sudo add-apt-repository -y --remove ppa:kgilmer/speed-ricer
}

Imagemagick() {
    sudo apt install -y imagemagick
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi
}

Jupyter() {
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
}

Navi() {
    sudo bash -c "$(wget -O- https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        ln -fs $HOME/Dotfiles/extras/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        ln -fs $HOME/Dotfiles/extras/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
}

Peek() {
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo apt update
    sudo apt install -y peek
    sudo add-apt-repository -y --remove peek-developers/stable
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
}

SSR() {
    wget -P $HOME/Desktop https://download.fastgit.org/shadowsocksrr/electron-ssr/releases/download/0.3.0-alpha.6/electron-ssr-0.3.0-alpha.6.deb
    sudo dpkg -i $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
    cd $HOME
    sudo rm -rf $HOME/Desktop/electron-ssr-0.3.0-alpha.6.deb
}

Dunst() {
    sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
    git clone https://hub.fastgit.org/dunst-project/dunst.git $HOME/Desktop/dunst
    cd $HOME/Desktop/dunst
    make
    sudo make install
    cd $HOME
    rm -rf $HOME/Desktop/dunst
}

VIM() {
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt update
    sudo apt install -y vim
    sudo add-apt-repository -y --remove ppa:jonathonf/vim
}

Offlineimap() {
    sudo cp /usr/share/doc/offlineimap/examples/systemd/offlineimap.service /etc/systemd/user
    systemctl --user enable offlineimap
    systemctl --user start offlineimap
}

Fcitx() {
    if [ -f $HOME/.config/fcitx/conf/fcitx-classic-ui.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-classic-ui.config
        sudo cp $HOME/Dotfiles/extras/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    else
        sudo cp $HOME/Dotfiles/extras/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    fi
}

GTK() {
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo cp $HOME/Dotfiles/extras/gtk3setting/settings.ini /etc/gtk-3.0/settings.ini
    fi
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
}

Github_Hosts() {
    python3 $HOME/Dotfiles/extras/github_hosts.py
}

I3_Sensible_Terminal() {
    if [ -f /usr/bin/i3-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/rofi-sensible-terminal
    fi
    if [ -f /usr/bin/rofi-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/i3-sensible-terminal
    fi
}

main() {


    echo " "
    echo "-------------------------------------------------------------------------------"
    echo " "
    echo "--help    Print this message"
    echo "-all      Install All tools"
    echo " "
    echo "-------------------------------------------------------------------------------"
    echo " "
    echo "-1        Alttab"
    echo "-2        Arcthemes"
    echo "-3        Arcicons"
    echo "-4        Alttab"
    echo "-5        Copytranslator"
    echo "-6        Crossover"
    echo "-7        I3gaps"
    echo "-8        Imagemagick"
    echo "-9        Jupyter"
    echo "-10       Navi"
    echo "-11       Peek"
    echo "-12       Picom"
    echo "-13       SSR"
    echo "-14       Dunst"
    echo "-15       VIM"
    echo "-16       Offlineimap"
    echo "-17       Fcitx"
    echo "-18       GTK"
    echo "-19       Github"
    echo "-20       Github_Hosts"
    echo "-21       I3_Sensible_Terminal"
    echo "-------------------------------------------------------------------------------"
    echo " "

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
            Alttab
            ;;
        -5)
            Copytranslator
            ;;
        -6)
            Crossover
            ;;
        -7)
            I3gaps
            ;;
        -8)
            Imagemagick
            ;;
        -9)
            Jupyter
            ;;
        -10)
            Navi
            ;;
        -11)
            Peek
            ;;
        -12)
            Picom
            ;;
        -13)
            SSR
            ;;
        -14)
            Dunst
            ;;
        -15)
            VIM
            ;;
        -16)
            Offlineimap
            ;;
        -17)
            Fcitx
            ;;
        -18)
            GTK
            ;;
        -19)
            Github
            ;;
        -20)
            Github_Hosts
            ;;
        -21)
            I3_Sensible_Terminal
            ;;
        -all)
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
            Github_Hosts
            I3_Sensible_Terminal
            Offlineimap
            Alttab
            # Copytranslator
            # Crossover
            # Picom
            # SSR
            # Github
            ;;
        *)
            echo "Command not found" >&2
            exit 1
    esac
}

main "$@"
