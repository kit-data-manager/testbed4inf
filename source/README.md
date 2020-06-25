# Testbed Setup

This is the simplest way to set up a local testing instance of the testbed. This folder contains a docker-compose.yml file that will set up services as easy as possible by compiling them in docker images and then running those in docker containers.

Since most of the services are very similar to compile, they share the `Dockerfile` and only differ by Dockerfile `ARG`uments given in the docker-compose.yml.

There are services which do not have public code-repositores yet to compile from. Those are handled differently.
TODO how are closed services handled?

## Developer documentation

Most services originating from KIT Data Manager are compiled using the same technologies. They usually need JDK-SE 8+ (openjdk11 recommended), are built using gradle and are started in a similar way. Therefore they can share the build-script, the run-script and even the `Dockerfile`. The difference will make the environment variables you can see in the `docker-compose.yml`. They are stored in the image (using `ARG` in the dockerfile) and given to the build-script at image-creation-time and to the run-script at container-run-time (using `ENV` in the dockerfile).
    - `SERVICE_FOLDER` stores the name of the repository folder name, which is the folder name in the url without the `.git` suffix.
    - `BINARY_NAME` is the name of the JAR-file without the `.jar` suffix.