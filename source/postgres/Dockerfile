FROM postgres:11
MAINTAINER webmaster@datamanager.kit.edu

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./docker-entrypoint-initdb.d/init.sh /docker-entrypoint-initdb.d/
