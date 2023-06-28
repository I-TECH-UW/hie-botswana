#!/bin/bash
TAG_NAME=${1:-latest}
docker build -t itechuw/hie-botswana:"$TAG_NAME" .
