#!/bin/sh
set -e

if [ -e /rttys/rttys.conf ]; then
    # randomize rttys http username and password
    USERNAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
    PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
    sed "s/http-username:.*/http-username: ${USERNAME}/g" /rttys/rttys.conf > tmp && cat tmp > /rttys/rttys.conf
    sed "s/http-password:.*/http-password: ${PASSWORD}/g" /rttys/rttys.conf > tmp && cat tmp > /rttys/rttys.conf
fi

exec "$@"