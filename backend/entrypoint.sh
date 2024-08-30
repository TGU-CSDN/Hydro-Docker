#!/bin/sh

ROOT=/root/.hydro

if [ ! -f "$ROOT/addon.json" ]; then
    echo '["@hydrooj/ui-default"]' > "$ROOT/addon.json"
fi

if [ ! -f "$ROOT/config.json" ]; then
    echo "{\"host\": \"$OJ_DB_HOST\", \"port\": \"$OJ_DB_PORT\", \"name\": \"$OJ_DB_NAME\", \"username\": \"$OJ_DB_USERNAME\", \"password\": \"$OJ_DB_PASSWORD\"}" > "$ROOT/config.json"
fi

if [ ! -f "$ROOT/.install.lock" ]; then
    echo "INSTALL LOCK FILE DO NOT REMOVE IT" > "$ROOT/.install.lock"

    hydrooj cli system set server.xff x-forwarded-for
    hydrooj cli system set server.xhost x-forwarded-host

    hydrooj cli user create systemjudge@systemjudge.local root rootroot 2
    hydrooj cli user setSuperAdmin 2
fi

pm2-runtime start hydrooj
