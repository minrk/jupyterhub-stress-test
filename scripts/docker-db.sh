#!/usr/bin/env bash
# source this file to setup postgres and mysql
# for local testing (as similar as possible to docker)

# simplified
set -eu
source "$(dirname $0)/../env"
export PGHOST=127.0.0.1
NAME="hub-test-db"
DOCKER_RUN="docker run -d --name $NAME"

docker rm -f "$NAME" 2>/dev/null || true

RUN_ARGS="-p 127.0.0.1:5432:5432 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:12.5"
CHECK="psql --user postgres -c \q"

$DOCKER_RUN $RUN_ARGS

echo -n "waiting for db "
for i in {1..60}; do
  if $CHECK; then
    echo 'done'
    break
  else
    echo -n '.'
    sleep 1
  fi
done
$CHECK

psql --user postgres -c "CREATE USER $PGUSER WITH PASSWORD '$PGPASSWORD';"
psql --user postgres -c "CREATE DATABASE jupyterhub;"
