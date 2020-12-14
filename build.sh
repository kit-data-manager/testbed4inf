#!/usr/bin/env bash
# 
# Usage: `bash build.sh` to build all services,
#        `bash build.sh fairris pit-service` to build only selected services.


echo "Building images."
echo "Called script with those parameters: $@"

docker-compose build $@

# Delete containers which may contain credentials or build artefacts.
docker rmi -f $(docker images -q --filter label=stage=build-contains-credentials)

echo "Finished building images."
echo "Use the following command to start only the just built images:"
echo "docker-compose up $@"
