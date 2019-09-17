#!/usr/bin/env bash

export GRAYLOG_PASSWORD_SECRET=$(<./secrets/GRAYLOG_PASSWORD_SECRET)
export GRAYLOG_ROOT_PASSWORD_SHA2=$(<./secrets/GRAYLOG_ROOT_PASSWORD_SHA2)

docker stack deploy -c docker-compose.yml archilab-logging

echo "Waiting for Graylog REST API ... (This may take some minutes)"
until [ "$(curl -s https://logs.archi-lab.io/api/system/lbstatus)" == "ALIVE" ]; do
    sleep 10
done

echo "Creating Global GELF UDP input via REST API:"
curl \
    -u admin:${GRAYLOG_PASSWORD_SECRET} \
    -H "X-Requested-By: https://logs.archi-lab.io" \
    -H "Content-Type: application/json" \
    -d @gelf-udp-input.json \
    https://logs.archi-lab.io/api/system/inputs
