#!/usr/bin/env bash
source /io/venv/bin/activate
cd /tmp
git clone https://github.com/jupyterhub/jupyterhub
cd jupyterhub
git fetch origin refs/pull/3177/merge
git checkout -b test-pr FETCH_HEAD
pip install .
