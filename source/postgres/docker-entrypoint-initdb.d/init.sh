#!/bin/bash
set -e
echo "Nothing to do. If required, add database initialization here."

# add additional databases to the default, which is set in the compose file.
# to add further databases and users, add the service name.
# the service name has to fit the db name and db user name.
# example: for service in pit metastore collectionapi; do ... done
for service in pit;
do
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
        CREATE USER $service;
        CREATE DATABASE $service;
        GRANT ALL PRIVILEGES ON DATABASE $service TO $service;
    EOSQL
done
