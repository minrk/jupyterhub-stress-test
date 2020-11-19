#!/usr/bin/env bash

source /io/venv/bin/activate
source /io/repo/env

if [[ "$@" == *postgres* ]]; then
  # reset docker db
  bash /io/repo/scripts/docker-db.sh
fi
# clear sqlite before starting
test -f jupyterhub.sqlite && rm -vf jupyterhub.sqlite

exec jupyterhub "$@"
