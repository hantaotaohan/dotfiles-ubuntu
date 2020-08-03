# Setup SSH keys
if ! [ -f $HOME/.ssh/id_rsa.pub ]
    then

    echo 'Email for ssh key'
    read -e ssh_email

    ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa

    echo 'Key copied to keyboard'

    xclip -sel clip < $HOME/.ssh/id_rsa.pub

    google-chrome --new-window 'https://github.com/settings/keys'
fi
