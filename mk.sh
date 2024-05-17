#!/bin/bash

./build-image.sh

# ./instant package remove -n monitoring --env-file .env
# ./instant package init -n monitoring --env-file .env

# ./instant package remove -n analytics-datastore-elastic-search --env-file .env
# ./instant package init -n analytics-datastore-elastic-search --env-file .env

#./instant package remove -n message-bus-kafka --env-file .env
#./instant package init -n message-bus-kafka --env-file .env

#./instant package remove -n database-postgres --env-file .env
#./instant package init -n database-postgres --env-file .env

#./instant package remove -n fhir-datastore-hapi-fhir --env-file .env
#./instant package init -n fhir-datastore-hapi-fhir --env-file .env

#./instant package remove -n interoperability-layer-openhim --env-file .env
#./instant package init -n interoperability-layer-openhim --env-file .env

./instant package remove -n client-registry-opencr --env-file .env
./instant package init -n client-registry-opencr --env-file .env

# ./instant package remove -n openhim-mediator-fhir-converter --env-file .env
# ./instant package init -n openhim-mediator-fhir-converter --env-file .env -d

#./instant package down -n reverse-proxy-ocl --env-file .env
# ./instant package up -n reverse-proxy-ocl --env-file .env

# ./instant package remove -n shared-health-record --env-file .env
# ./instant package init -n shared-health-record --env-file .env -d

#./instant package remove -n openhim-mediator-omang-service --env-file .env 
#./instant package init -n openhim-mediator-omang-service --env-file .env

