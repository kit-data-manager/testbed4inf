This folder contains a docker-compose.yml file that will set up services as easy as possible by compiling them in docker images and then running those in docker containers.

Since most of the services are very similar to compile, they share the `Dockerfile` and only differ by Dockerfile `ARG`uments given in the docker-compose.yml.

There are services which do not have public code-repositores yet to compile from. Those are handled differently.
TODO how are closed services handled?