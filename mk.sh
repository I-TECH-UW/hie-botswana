#!/bin/bash

./build-image.sh

./instant package remove -n shared-health-record --env-file .env
./instant package remove -n message-bus-kafka --env-file .env
#./instant package remove -n client-registry-opencr --env-file .env
#./instant package remove -n openhim-mediator-fhir-converter --env-file .env
#./instant package remove -n reverse-proxy-nginx --env-file .env
#./instant package remove -n interoperability-layer-openhim --env-file .env
#./instant package remove -n openhim-mediator-omang-service --env-file .env

./instant package init -n message-bus-kafka --env-file .env
#./instant package init -n client-registry-opencr --env-file .env
#./instant package init -n openhim-mediator-fhir-converter --env-file .env
#./instant package init -n reverse-proxy-nginx --env-file .env
#./instant package init -n interoperability-layer-openhim --env-file .env
./instant package init -n shared-health-record --env-file .env -d
#./instant package init -n openhim-mediator-omang-service --env-file .env


# docker stack deploy         -c ./interoperability-layer-openhim/docker-compose.yml                  --with-registry-auth         openhim