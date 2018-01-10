#!/bin/sh

DO_API_KEY=$1
TAG=$2
AGENT_KEY=$3

curl -X POST https://api.digitalocean.com/v2/droplets \
-H 'Content-Type: application/json' \
-H "Authorization: Bearer $DO_API_KEY" \
-d '{"name":"calculatorservice01", "region":"nyc3", "size":"1gb",
     "image":"25909727", "ssh_keys":["17289971"],
     "tags":["'$TAG'"],
     "user_data":"
#cloud-config
runcmd:
  - curl -O https://raw.githubusercontent.com/carlosbunn/deployment-pipeline1/master/install.sh
  - /bin/sh -x install.sh '$AGENT_KEY'
"}'
