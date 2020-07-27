#!/bin/bash

Path1=$HOME/Vimwiki/src/img/
Path2=$HOME/Vimwiki/docs/img/

monitor() {
  inotifywait -mrq --format '%w%f' -e create,close_write,delete $1 | while read
        rsync -rtvu --delete ${Path1} ${Path2}
  done
}

monitor ${Path1};
