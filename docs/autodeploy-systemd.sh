#!/usr/bin/env bash

set -ex

if [[ ! "$EUID" == "0" ]]; then
    echo "Run as root or w/ sudo"
    exit
fi

[[ ! -d /etc/postlogue ]] && mkdir /etc/postlogue

cp settings.yaml /etc/postlogue/.

echo > /etc/systemd/system/postlogue.service << EOF
[Unit]
Description=Runs Prologue as a service
After=network.target
Wants=network-online.target

[Service]
Restart=always
Type=simple
ExecStart=/usr/bin/postlogue -c /etc/postlogue/settings.yaml
Environment=

[Install]
WantedBy=multi-user.target 
EOF

systemctl daemon-reload
systemctl enable --now postlogue

echo "Done!"