#!/bin/sh
set -e

if [ -e /rttys/rttys.conf ]; then
    # randomize rttys http username and password
    USERNAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
    PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
    temp_file=$(mktemp)
    # ignore errors as filesystem may be mounted as read only
    sed "s/http-username:.*/http-username: ${USERNAME}/g" /rttys/rttys.conf > $temp_file && cat $temp_file > /rttys/rttys.conf || true
    sed "s/http-password:.*/http-password: ${PASSWORD}/g" /rttys/rttys.conf > $temp_file && cat $temp_file > /rttys/rttys.conf || true
fi

exec "$@"