#!/bin/sh

CONFIG_FILE=/root/.hydro/judge.yaml
CONFIG_FILE_DEFAULT=/tmp/.hydro/judge.yaml

if [ ! -f "$CONFIG_FILE" ]; then
  cp $CONFIG_FILE_DEFAULT $CONFIG_FILE
  echo 'Default judge file has been created'
fi

pm2 start /root/run-sandbox.sh
pm2-runtime start hydrojudge
