#!/usr/bin/env bash
# 
# Usage: `bash build.sh`
# 
# This will build the testbed containers correctly.
# Note that you currently need an ssh key to access the repositories.
# Your key will be copied into an intermediate container, which will
# be deleted in the end of this script.

SSH_KEY_FILE=~/.ssh/id_rsa

docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat $SSH_KEY_FILE)" fairris #pit-service

# Delete containers with credentials.
docker rmi -f $(docker images -q --filter label=stage=build-contains-credentials)