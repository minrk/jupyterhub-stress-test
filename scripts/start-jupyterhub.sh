#!/usr/bin/env bash
set -ex
sudo systemctl stop jupyterhub
sudo systemctl stop jupyterhub-postgres

unit="${1:-jupyterhub}"
sudo systemctl start "${unit}"
sudo systemctl status "${unit}"
