# testbed4inf


[![Test Build](https://github.com/kit-data-manager/testbed4inf/actions/workflows/main.yml/badge.svg)](https://github.com/kit-data-manager/testbed4inf/actions/workflows/main.yml)

Testbed for a generic FAIR DO infrastructure. Current functionalities:

- Create, Update and Retrieve PIDs
- Search within PID records
- Notification of PID activities for other services
- Includes an instance of our collection registry to create and manage collections

Related Publications:

- [Poster from RDA VP17 Poster Session](https://www.doi.org/10.5445/IR/1000131613)

## Goals

This testbed is meant to be used as ...

- a Foundation for experimenting with FAIR use cases (indexing, profiles, records, ...). The idea is to find situations where specification is missing and explore problems as early as possible.
- a Playground for understanding how a FAIR ecosystem will work.
- (in the not so near future) as a configurable (but pre-configured) basis for FAIR DO ecosystems.

## Getting Started

> IMPORTANT: Before you start, make sure your docker environment has at least 4GB of memory (RAM) available. This is especially required if it runs in a virtual machine (which is the case e.g. if you use OSX). You can do this the easiest using Docker Desktop in the preference menu under "Resources". The testbed consists of several services, and in sum the default of 2GB RAM will not be enough.

```bash
# install docker first.
git clone $THIS_REPOSITORY_URL
cd testbed4inf
docker compose up  # start all services of the testbed
```

Wait until the containers are started. After that, you may expore the possibilities of the testbed using the following URLs:

- [Fairris Web Interface: http://localhost:8080/](http://localhost:8080/)
    - A simple web interface for simplified testbed experimentation purposes. You can register simplified but valid records and get a feeling for the tasks FAIR enabled research software needs to do in the background. It is meant to exist in the testbed only. It tries to mimic a hypothetical, specialized interface for researchers.
- [PIT-Service API Documentation: http://localhost:8090/swagger-ui.html](http://localhost:8090/swagger-ui.html)
    - Use this API to manage PID records. You can find [details about the PIT-Service here](https://github.com/kit-data-manager/pit-service).
- [Message Broker Management UI](http://localhost:15672/#/)
    - The message broker will receive messages from the PIT service when records are created or updated. The broker will persist those messages in the queues of interested (registered) clients. In the testbed is currently only one such client: The indexer, which will receive the messages, resolve the record and finally ingest all information into the seach index. This interface will let you watch into internal statistics and the internal state of the broker.
- [Search Index Management UI: http://localhost:5601/app/kibana](http://localhost:5601/app/kibana)
    - Use this interface to create a view on the record index and create queries. There are also APIs available directly to the elasticsearch index, which enables developers to create different kinds of search experiences.
- [Collection Service API Documentation: http://localhost:8091/swagger-ui.html](http://localhost:8091/swagger-ui.html)
    - Use this API to manage collections. You can find [details about the collection service here](https://github.com/kit-data-manager/collection-api).
- [Collection Service Content Map: http://localhost:8091/static/overview.html](http://localhost:8091/static/overview.html)
    - If you registered Collections using the API, you can get an overview of the registered collections using this interface.

## Customization

Detailed usage documentation beyond the short "getting started" introduction.

The testbed consists of several services, managed with docker-compose. Some of them do not yet have an image on docker hub and need to be built on the machine. This will happen automatically when starting them.

Use `docker compose up` to start all services or `docker compose up fairris pit-service` to only start a selection, analogous to the build steps.

### Update services

```bash
git pull
docker compose down  # shut down all services and delete its containers
docker compose pull  # pull new image versions
docker-compose up    # starts all services
```

## Repository structure

- The `documentation` folder contains advanced documentation about the testbed and some workflows within it for some better understanding of the architecture.
- Service-specific files are in folders named after the service. The configurations inside the folders are used either at build time or container creation time. So if you want to change the configuration, you need to make sure to execute the corresponding action afterwards, in order to use the new configurations.
- `docker-compose.yml` contains all services and how they are wired together.
    - It is recommended to use override files to make custom modifications. It will make pulling new versions of the repository easier for you.
    - Use the compose file as a documentation of exposed ports etc.
- `java-release-run.sh` will be copied into the images of java-based services to run them properly (helper script).
