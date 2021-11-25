FROM openjdk:11-buster AS build-env-java
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
    git clone -v https://github.com/kit-data-manager/pit-service.git service && \
    cd service && \
    ./gradlew build --stacktrace && \
    cp build/libs/pit-service*.jar ../


# Clean image
FROM openjdk:11-buster as run-pit
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
RUN mkdir -p /kitdm20/config
COPY java-release-run.sh /kitdm20/
COPY --from=build-pit /kitdm20/pit-service*.jar /kitdm20/pit-service.jar
COPY pit-service/conf/application.properties /kitdm20/config/application.properties
EXPOSE 8080
CMD bash /kitdm20/java-release-run.sh pit-service.jar
