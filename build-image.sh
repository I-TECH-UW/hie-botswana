#!/bin/bash
TAG_NAME=${1:-latest}
docker build -t i-tech-uw/hie-botswana:"$TAG_NAME" .
