source /io/venv/bin/activate
source /io/.env
if [[ "$@" == *postgres* ]]; then
  # reset docker db
  bash /io/docker-db.sh
fi
# clear sqlite before starting
test -f jupyterhub.sqlite && rm -vf jupyterhub.sqlite

exec jupyterhub "$@"
