# Dotfiles

> Hantaotaohan - TaoTao - Saber - Desktop & Server

----

**Auto Mode Install**

```bash

# Ubuntu - Server

sh -c "$(wget -O- https://raw.githubusercontent.com/hantaotaohan/Dotfiles/master/install/run_server.sh)"

# Ubuntu - Desktop

sh -c "$(wget -O- https://raw.githubusercontent.com/hantaotaohan/Dotfiles/master/install/run_desktop.sh)"
```

----

if need setup obsidian

```bash
sudo wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.7.6/obsidian_0.7.6_amd64.snap
sudo snap install ./obsidian_0.7.6_amd64.snap --dangerous
```

if need setup foliate

```bash
sudo snap install foliate
```

if 
failed: Connection refused.

sudo vim /etc/hosts

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

install Peek
```bash
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
```

install goodsync
gsync job 123 /f1=$HOME/vimwiki/ /f2=$HOME/Desktop/ /dir=ltor
gsync analyze /all
gsync 123

rsync -rtvu --delete source_folder/ destination_folder/
