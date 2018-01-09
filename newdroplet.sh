#!/bin/sh

curl -X POST https://api.digitalocean.com/v2/droplets \
-H 'Content-Type: application/json' \
-H "Authorization: Bearer $DO_API_KEY" \
-d '{"name":"calculatorservice", "region":"nyc3", "size":"512mb",
     "image":"18325354", "ssh_keys":[gocd-carlos],
     "user_data":"
#cloud-config
runcmd:
  - sh -x  < <(curl -s https://raw.githubusercontent.com/carlosbunn/deployment-pipeline1/master/install.sh)
"}'
