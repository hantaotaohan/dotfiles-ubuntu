# Dotfiles

> TaoTao - Saber - Desktop & Server

## Info

**Screenshot**

<table>
    <tr>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/1.png" width = "300" height = "200" alt="" align=center /></center></td>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/2.png" width = "300" height = "200" alt="" align=center /></center></td>
    </tr>
    <tr>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/3.png" width = "300" height = "200" alt="" align=center /></center></td>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/4.png" width = "300" height = "200" alt="" align=center /></center></td>
    </tr>
</table>

---

**Desktop Edition** : Including I3wm desktop configuration based on Ubuntu Server version

**Server  Edition** : It is a refined workspace based on Ubuntu Server

## Detailed introduction

**Desktop Edition** 
- CLI
  - Fd
  - Bash - A Unix shell and command language.
  - Xclip
  - Ranger
  - Silversearcher-ag
  - Unzip
  - ctags
  - Curl
  - Inotify-tools
  - Z - Tracks your most used directories, based on frecency.
  - Tmux - A terminal multiplexer.
  - Git - A free and open source distributed version control system.
  - Diff-so-fancy - Make your diffs human readable instead of machine readable.
  - Htop - An interactive text-mode process viewer.
  - Bat - A cat clone with syntax highlighting and Git integration.
  - Fzf - A command-line fuzzy finder.
  - Ripgrep - A line-oriented search tool that recursively searches directories for a regex pattern.
  - Wget - A free software package for retrieving files using HTTP, HTTPS, FTP, and FTPS.
  - Vim
    - vim-airline 
    - onedark.vim  
    - vim-airline 
    - vim-airline-themes
    - vim-fugitive
    - nerdtree
    - tabular
    - vim-table-mode
    - tagbar
    - fzf
    - asyncrun
    - vim-tmux-navigator
    - indentLine
    - nerdcommenter
    - vim-startify
    - ultisnips
    - vim-snippets
    - markdown-preview
    - markdown2ctags
    - neuims
    - fcitx.vim
    - md-img-paste
    - vimwiki
    - vim-zettel
    - vim-multiple-cursors
  - Pip Tools
    - Powerline-shell
    - Pandas
    - Django
    - Pyvirtualdisplay
    - Selenium
  - Gem Tools
    - Vimwiki_markdown

- GUI
  - i3 - A tiling window manager.
  - i3blocks - A feed generator for text based status bars.
  - i3lock-fancy - A script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.
  - Rofi - A window switcher, application launcher and dmenu replacement.
  - Compton - A lightweight compositor for X11.
  - Alacritty - A cross-platform, GPU-accelerated terminal emulator.
  - zathura
  - open-vm-tools-desktop
  - calibre
  - deepin-screenshot
  - Fcitx
  - Chrome
  - Fonts
    - Inziu
    - NordFonts
    
----

## How to Install

### Manual installation

```bash
git clone https://github.com/hantaotaohan/Dotfiles.git

# Users in China
git clone https://hub.fastgit.org/hantaotaohan/Dotfiles.git

cd Dotfiles

./install.sh
```

### Auto Mode Install


```bash

sh -c "$(wget -O- https://raw.githubusercontent.com/hantaotaohan/Dotfiles/master/setup/auto_run_install.sh)"

```

### If Problems

> If it prompts failed: Connection refused.

```bash
sudo vim /etc/hosts
```
Copy the following content in

```bash
# GitHub Start
52.74.223.119 github.com
192.30.253.119 gist.github.com
54.169.195.247 api.github.com
185.199.111.153 assets-cdn.github.com
151.101.76.133 raw.githubusercontent.com
151.101.108.133 user-images.githubusercontent.com
151.101.76.133 gist.githubusercontent.com
151.101.76.133 cloud.githubusercontent.com
151.101.76.133 camo.githubusercontent.com
151.101.76.133 avatars0.githubusercontent.com
151.101.76.133 avatars1.githubusercontent.com
151.101.76.133 avatars2.githubusercontent.com
151.101.76.133 avatars3.githubusercontent.com
151.101.76.133 avatars4.githubusercontent.com
151.101.76.133 avatars5.githubusercontent.com
151.101.76.133 avatars6.githubusercontent.com
151.101.76.133 avatars7.githubusercontent.com
151.101.76.133 avatars8.githubusercontent.com
192.30.253.112 github.com
185.199.108.153 assets-cdn.github.com 
151.101.185.194 github.global.ssl.fastly.net
140.82.114.9 codeload.github.com
# GitHub End
```

----

## Additional installation

### Update Vim8.2

> Update Vim

```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update

# if network slow also
sudo sed -i "s/http:\/\/ppa\.launchpad\.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list

sudo apt install vim
sudo add-apt-repository --remove ppa:jonathonf/vim
```

### TabViewer

> A tool for terminal to view CSV file

[link](https://github.com/TabViewer/tabview)

### Obsidian

```bash
sudo wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.7.6/obsidian_0.7.6_amd64.snap
sudo snap install ./obsidian_0.7.6_amd64.snap --dangerous
```

### Foliate

> E-book viewing software

```bash
sudo snap install foliate
```

### Peek

> Recording GIF software

```bash
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
sudo add-apt-repository --remove peek-developers/stable
```

### Vmware-tools-patches

> VMware Tools patch file Solve the problem of VMware sharing files

```bash
$ git clone https://github.com/rasa/vmware-tools-patches.git
$ cd vmware-tools-patches
$ ./download-tools.sh latest
$ ./untar-and-patch.sh
$ ./compile.sh

$ sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other,nonempty
```

### TimeShift

> System backup software

```bash
wget https://github.com/teejee2008/timeshift/releases/download/v20.03/timeshift-v20.03-amd64.deb
sudo dpkg -i timeshift-v20.03-amd64.deb
sudo apt install -f
sudo dpkg -i timeshift-v20.03-amd64.deb
```

### Install Other Fonts

> Chinese font

```bash
sudo apt install fonts-noto-cjk
```

### Mouse

> Mouse driven

```bash
sudo apt install solaar
```

### Fiddler

> Bag grabbing tool

```bash
wget -c "https://downloads.getfiddler.com/linux/fiddler-everywhere-1.0.0.AppImage" -O fiddler.AppImage
sudo ln -f fiddler.AppImage /usr/local/bin/
```

### ImageMagick

> Conver png > pdf Tools

```bash
wget https://www.imagemagick.org/download/ImageMagick.tar.gz
cd ImageMagick
./configure
make
sudo make install
sudo ldconfig /usr/local/lib
magick -version
# magick pdfname.pdf image.png
# or
# magick imagename.png pdfname.pdf
# or
------------------------------------------------------------------
sudo apt install imagemagick
sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
```

### Navi

> Cheatsheet

```bash
sudo bash -c "$(wget -O- https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)"
```

### CopyTranslator

> Translator

[Link](https://github.com/CopyTranslator/CopyTranslator)

### Mailspring

> Email

[Link](https://github.com/Foundry376/Mailspring)

### Tesseract-ocr

> OCR

```bash
sudo apt install tesseract-ocr
sudo apt install tesseract-ocr-chi-sim
sudo add-apt-repository ppa:sandromani/gimagereader
sudo apt install gimagereader
```

### Config I3blocks-email

> i3blocks-email config

```bash
python3 $HOME/.config/i3blocks/email --add $Email@xxx.com
```

### Gtk3.0 thmees

> themes

```bash
sudo apt install arc-theme
sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
```

### SSR
 > ssr
 
 https://github.com/shadowsocksrr/electron-ssr

### If time Error

```bash
timedatectl set-local-rtc 1 --adjust-system-clock
```

### keyring config (neomutt password settings)
```python
python3
import keyring
keyring.set_password("system", "username", "password")
```
