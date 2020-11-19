#!/usr/bin/env bash
# gcp-startup script

set -exuo pipefail
mkdir -p /io
test -d /io/repo || git clone https://github.com/minrk/jupyterhub-stress-test /io/repo

cd /io

cd /io/repo
git fetch origin
git reset origin/main --hard

# make the dir admin-writable
chown -R :adm /io
chmod -R g+w /io

bash scripts/install.sh &>> /tmp/install.log
bash scripts/docker-db.sh &>> /tmp/install.log
