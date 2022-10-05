#!/usr/bin/env bash

set -ex

if [[ ! "$EUID" == "0" ]]; then
    echo "Run as root or w/ sudo"
    exit
fi

[[ ! -d /etc/postlogue ]] && mkdir /etc/postlogue

cp settings.yaml /etc/postlogue/.
cp sample.service /etc/systemd/system/postlogue.service
cp postlogue /usr/bin/.

systemctl daemon-reload
systemctl enable --now postlogue

echo "Done!"