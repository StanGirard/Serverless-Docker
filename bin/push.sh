#!/bin/bash
set -e 
echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin
docker push stangirard/serverless:latest;
docker push stangirard/serverless:"$RELEASE";
