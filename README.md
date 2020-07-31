# Dotfiles

> TaoTao - Saber - Desktop & Server

## Info

**Screenshot**

<table>
    <tr>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/1.png" width = "600" height = "300" alt="" align=center /></center></td>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/2.png" width = "600" height = "300" alt="" align=center /></center></td>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/3.png" width = "600" height = "300" alt="" align=center /></center></td>
        <td ><center><img src="https://github.com/hantaotaohan/Dotfiles/raw/master/readme/image/4.png" width = "600" height = "300" alt="" align=center /></center></td>
    </tr>

</table>


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

###  obsidian

```bash
sudo wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.7.6/obsidian_0.7.6_amd64.snap
sudo snap install ./obsidian_0.7.6_amd64.snap --dangerous
```

### foliate

```bash
sudo snap install foliate
```

### Peek

```bash
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
```

### Vmware-tools-patches

```bash
$ git clone https://github.com/rasa/vmware-tools-patches.git
$ cd vmware-tools-patches
$ ./download-tools.sh latest
$ ./untar-and-patch.sh
$ ./compile.sh
```
