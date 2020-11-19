#!/usr/bin/env bash

sudo apt update
sudo apt install -y python3-venv postgresql-client docker.io npm
python3 -m venv /io/venv
source /io/venv/bin/activate
pip install -r requirements.txt
sudo npm i -g configurable-http-proxy
