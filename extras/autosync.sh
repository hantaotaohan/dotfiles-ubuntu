#!/bin/bash

Path1=$HOME/Vimwiki/src/img/
Path2=$HOME/Vimwiki/docs/img/


monitor() {
  inotifywait -mrq --format '%w%f' -e create,close_write,delete $1 | while read line; do
        rsync -rtvu --delete ${Path1} ${Path2}
  done
}


processName="autosync.sh"
processNum=`ps -aef |grep "${processName}" | wc -l`

if [ "${processNum}" -gt "3" ]; then
  exit
fi

monitor ${Path1};
