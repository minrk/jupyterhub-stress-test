#!/usr/bin/env bash
sudo systemctl stop jupyterhub
sudo systemctl stop jupyterhub-postgres

sudo systemctl start "${1:-jupyterhub}"
