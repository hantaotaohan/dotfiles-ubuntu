#!/bin/bash

grep -io "# Github" ~/Desktop/test > /dev/null
if [[ $? -eq 1 ]]; then
    sed -i '$a # GitHub Start' /etc/hosts
    sed -i '$a 52.74.223.119 github.com' /etc/hosts
    sed -i '$a 192.30.253.119 gist.github.com' /etc/hosts
    sed -i '$a 54.169.195.247 api.github.com' /etc/hosts
    sed -i '$a 185.199.111.153 assets-cdn.github.com' /etc/hosts
    sed -i '$a 151.101.76.133 raw.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.108.133 user-images.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 gist.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 cloud.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 camo.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars0.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars1.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars2.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars3.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars4.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars5.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars6.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars7.githubusercontent.com' /etc/hosts
    sed -i '$a 151.101.76.133 avatars8.githubusercontent.com' /etc/hosts
    sed -i '$a 192.30.253.112 github.com' /etc/hosts
    sed -i '$a 185.199.108.153 assets-cdn.github.com' /etc/hosts
    sed -i '$a 151.101.185.194 github.global.ssl.fastly.net' /etc/hosts
    sed -i '$a 140.82.114.9 codeload.github.com' /etc/hosts
    sed -i '$a # GitHub End' /etc/hosts
    echo "修改HOSTS成功，已添加Github"
else
    echo "HOSTS已有Github字段"
fi
