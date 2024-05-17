#!/bin/sh

rm -f /src/server/config/config_${NODE_ENV}.json
cp /src/server/config/config_ro.json /src/server/config/config_${NODE_ENV}.json
chmod +w /src/server/config/config_${NODE_ENV}.json

node lib/app.js

# spin up for docker exec access
#tail -f /dev/null