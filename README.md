# testbed4inf

Testbed for FAIR DO infrastructure.

- `source`: Contains a fully automated way to set up the testbed for local testing. It will compile the services within docker images and set them up using docker-compose. Use `docker-compose up` so start.
    - Tools needed: `docker`, `docker-compose`
    - Services available for one-command-setup:
        - base-repository
        - collection-repository
    - Services currently only available by providing the according JAR file:
        - pit-service
        - metastore2

TODO explain how the services have to be handled that do currently not have public available code repositories.

TODO further usage instructions.