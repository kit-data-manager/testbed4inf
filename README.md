# testbed4inf

Testbed for FAIR DO infrastructure.

## Goals

This testbed is meant to be used as ...

- a Foundation for experimenting with FAIR use cases (indexing, profiles, records, ...). The idea is to find situations where specification is missing and explore problems as early as possible.
- a Playground for understanding how a FAIR ecosystem will work.
- (in the not so near future) as a configurable (but pre-configured) basis for FAIR DO ecosystems.

## Build services

The testbed consists of several services, managed with docker-compose. To build the services from scratch, use the build script like this:

```bash
# build all services
bash build.sh
# build only the services "fairris" and "pit-service"
bash build.sh fairris pit-service
```

## Run services

Use `docker-compose up` to start all services or `docker-compose up fairris pit-service` to only start a selection, analogous to the build steps.

## Use the testbed

The testbed has a simple web interface for simple experimentation purposes, called "Fairris". Visit http://localhost:8080/ to access it. As you can see in the compose file, the service expose several ports. So you can directly access their APIs.

## Update services

```bash
git pull
docker-compose down  # shut down all services and delete its containers
docker-compose pull  # pull new image versions
bash build.sh        # build service images which are not directly provided (yet)
docker-compose up    # starts all services
```

## Repository structure

- The `documentation` folder contains documentation about the testbed and some workflows within it for some better understanding of the architecture.
- Service specific files are in folders named after the service.
- build.sh is a convenience script to simplify using the docker-compose build command.
- docker-compose.yml contains all services and how they are wired together.
    - It is recommended to use override files to make custom modifications. It will make pulling new versions of the repository easier for you.
    - Use the compose file as a documentation of exposed ports etc.
- java-release-run.sh will be copied into the images of java-based services to run them properly.