#!/bin/bash

if type vmhgfs-fuse >/dev/null 2>&1; then
    sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other,nonempty ;
fi
