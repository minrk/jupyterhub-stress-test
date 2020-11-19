#!/usr/bin/env bash

cat << EOF > /etc/profile.d/venv.sh
test -d /io/venv && source /io/venv/bin/activate
test -f /io/repo/env && source /io/repo/env
EOF

sudo apt update
sudo apt install -y python3-venv postgresql-client docker.io npm tmux

python3 -m venv /io/venv
source /io/venv/bin/activate
pip install -r requirements.txt

sudo npm i -g configurable-http-proxy

sudo cp -v units/*.service /etc/systemd/system/
sudo systemctl daemon-reload
