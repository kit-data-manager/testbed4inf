# testbed4inf

Testbed for FAIR DO infrastructure.

## build services

The testbed consists of several services, managed with docker-compose. To build the services from scratch, use the build script like this:

```
# build all services
bash build.sh
# build only the services "fairris" and "pit-service"
bash build.sh fairris pit-service
```

TODO This assumes that you have access to the source code. What to do if only images were provided?

## run services

Use `docker-compose up` or `docker-compose up fairris pit-service`, analogous to the build steps.

## use

The testbed can be used by the client, called "Fairris". Access http://localhost:8080/ to access it.

## Repository structure

- Service specific files are in folders named after the service.
- build.sh is a convenience script to simplify using the docker-compose build command. This is not trivial since it will use your ssh key for git clone (see Dockerfiles).
- docker-compose.yml contains all services and how they are wired together.
- java-release-run.sh will be copied into the images of java-based services to run them properly.