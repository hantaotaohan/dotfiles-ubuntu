#!/bin/bash

Path1=$HOME/1
Path2=$HOME/2

monitor() {
  /usr/bin/inotifywait -mrq --format '%w%f' -e create,close_write,delete $1 | while read
    if [ -f $line ]; then
      rsync -rtvu $line --delete ${Path1} ${Path2}
    else
      cd $1 &&
        rsync -rtvu ./ --delete ${Path1} ${Path2}
    fi
  done
}

monitor ${Path1};
