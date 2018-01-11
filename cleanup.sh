#!/bin/bash

DO_API_KEY=$1

curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_KEY" "https://api.digitalocean.com/v2/droplets?tag_name=build"
curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_KEY" "https://api.digitalocean.com/v2/droplets?tag_name=production"

sleep 20
