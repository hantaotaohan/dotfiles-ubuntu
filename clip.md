wget https://download.fastgit.org/gohugoio/hugo/releases/download/v0.79.1/hugo_extended_0.79.1_Linux-64bit.deb -O $HOME/desktop/hugo.deb

cd $HOME/desktop

sudo dpkg -i hugo.deb

cd $HOME

rm -rf $HOME/desktop/hugo.deb
