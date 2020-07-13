# Dotfiles

> Hantaotaohan - TaoTao - Saber - Desktop & Server

----

**Auto Mode Install**

```bash

# Ubuntu - Server

sh -c "$(wget --no-check-certificate https://raw.githubusercontent.com/hantaotaohan/Dotfiles/master/install/run_server.sh -O -)"

# Ubuntu - Desktop

sh -c "$(wget --no-check-certificate https://raw.githubusercontent.com/hantaotaohan/Dotfiles/master/install/run_desktop.sh -O -)"

```

----

if need setup obsidian

```bash
sudo wget -q -t 0 -P $HOME/extras https://github.com/obsidianmd/obsidian-releases/releases/download/v0.7.6/obsidian_0.7.6_amd64.snap
cd extras
sudo snap install ./obsidian_0.7.6_amd64.snap --dangerous
```

if need setup foliate

```bash
sudo snap install foliate
```
