FROM openjdk:17-bullseye AS build-env-java
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-env
RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --no-install-recommends --assume-yes git && \
    mkdir -p /var/repository && \
    mkdir -p /kitdm20/


FROM build-env-java as build-pit
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-contains-credentials
RUN cd /kitdm20/ && \
    git clone -v https://github.com/kit-data-manager/pit-service.git --branch master service && \
    cd service && \
    ./gradlew build --stacktrace && \
    cp build/libs/TypedPIDMaker*.jar ../


# Create a clean, minimal image
FROM openjdk:17-bullseye as run-pit
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
RUN mkdir -p /kitdm20/config
COPY java-release-run.sh /kitdm20/
COPY --from=build-pit /kitdm20/TypedPIDMaker*.jar /kitdm20/TypedPIDMaker.jar
COPY pit-service/conf/* /kitdm20/config/
EXPOSE 8080
CMD bash /kitdm20/java-release-run.sh TypedPIDMaker.jar
