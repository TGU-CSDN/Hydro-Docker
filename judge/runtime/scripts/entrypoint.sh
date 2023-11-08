#!/bin/sh

CONFIG_FILE=/root/.hydro/judge.yaml
CONFIG_FILE_DEFAULT=/tmp/.hydro/judge.yaml

MOUNT_FILE=/root/.hydro/mount.yaml
MOUNT_FILE_DEFAULT=/tmp/.hydro/mount.yaml

if [ ! -f "$CONFIG_FILE" ]; then
  cp $CONFIG_FILE_DEFAULT $CONFIG_FILE
  echo 'Default judge file has been created'
fi

if [ ! -f "$MOUNT_FILE" ]; then
  cp $MOUNT_FILE_DEFAULT $MOUNT_FILE
  echo 'Mount config file has been created'
fi

pm2-runtime start /root/pm2.json
