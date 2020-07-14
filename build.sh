#!/usr/bin/env bash
# 
# Usage: `bash build.sh` to build all services,
#        `bash build.sh fairris pit-service` to build only selected services.
# 
# This will build the testbed containers correctly.
# Note that you currently need an ssh key to access the repositories.
# Your key will be copied into an intermediate container, which will
# be deleted in the end of this script.

SSH_KEY_FILE=~/.ssh/id_rsa

echo "Building images."
echo "Called script with those parameters: $@"

docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat $SSH_KEY_FILE)" $@

# Delete containers with credentials.
docker rmi -f $(docker images -q --filter label=stage=build-contains-credentials)

echo "Finished building images."
echo "Use the following command to start the just build images:"
echo "docker-compose up $@"
