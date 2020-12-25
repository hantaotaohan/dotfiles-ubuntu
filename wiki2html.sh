cd $HOME/blog
env HUGO_baseURL="$HOME/blog/public/" \
    hugo --themesDir $HOME/blog/themes/ -t zdoc \
    --config $HOME/blog/config/_default/config.toml \
    --contentDir $HOME/blog/content/en \
    -d $HOME/blog/public --quiet > /dev/null
