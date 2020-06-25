#!/bin/bash
set -e

# add additional databases to the default, which is set in the compose file.
# to add further databases and users, add the service name.
# the service name has to fit the db name and db user name.
# example: for service in pit metastore collectionapi; do ... done
echo "User and DB used to create new users and dbs: user=$POSTGRES_USER, db=$POSTGRES_DB"
for service in pit collection metastore2;
do
    echo "Will create user and db named $service."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
        CREATE USER $service;
        CREATE DATABASE $service;
        GRANT ALL PRIVILEGES ON DATABASE $service TO $service;
EOSQL
done
