#!/usr/bin/env bash

export GCP_ZONE=${GCP_ZONE:-europe-west1-b}
instances=$(gcloud compute instances list "$@"  --format json | jq -r '.[].name')

for inst in $instances; do
  echo "$inst"
  # gcloud compute ssh "$inst" --zone=${zone} -- top -b -n 1 | head -n 15
  # gcloud compute ssh "$inst" --zone=${zone} -- ls /io/runs/* | tail -n 10
  echo "collector running?"
  gcloud compute ssh "$inst" --zone=${zone} -- ps ax | grep collect.py
  echo "syncing files"
  rsync -e $(dirname "$0")/gcp-ssh -varuP $inst:/io/runs/ ./runs/
  echo -e "$inst\n\n"
done
