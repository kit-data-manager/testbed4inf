FROM openjdk:11-buster
MAINTAINER webmaster@datamanager.kit.edu

RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --assume-yes git && \
    mkdir -p /var/repository && mkdir -p /kitdm20/

COPY java-release-build.sh /kitdm20/
COPY java-release-run.sh /kitdm20/

ARG SERVICE_FOLDER
ARG BINARY_NAME
ENV SERVICE_FOLDER=${SERVICE_FOLDER}
ENV BINARY_NAME=${BINARY_NAME}

RUN bash /kitdm20/java-release-build.sh $SERVICE_FOLDER $BINARY_NAME
COPY baserepo/conf/application.properties /kitdm20/$SERVICE_FOLDER/release/config/application.properties

EXPOSE 8080
CMD bash /kitdm20/java-release-run.sh $SERVICE_FOLDER $BINARY_NAME
