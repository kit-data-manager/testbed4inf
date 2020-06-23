FROM openjdk:11-buster
MAINTAINER webmaster@datamanager.kit.edu

RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --assume-yes git

RUN mkdir -p /var/repository
RUN mkdir -p /kitdm20/

COPY build.sh /kitdm20/
COPY run.sh /kitdm20/

RUN sh /kitdm20/build.sh
COPY conf/application.properties /kitdm20/collection-api/release/config/application.properties

EXPOSE 8080
CMD ["/kitdm20/run.sh"]
