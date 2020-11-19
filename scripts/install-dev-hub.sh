#!/usr/bin/env bash
source /io/venv/bin/activate
cd /tmp
git clone https://github.com/jupyterhub/jupyterhub
cd jupyterhub
git fetch origin refs/pull/3261/merge
git checkout -b pr3261 FETCH_HEAD
pip install .
