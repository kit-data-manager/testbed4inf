# This is the base for building a java service.
# Since the building images should be deleted immediately due to their credentials,
# having a separate, clean base environment will speed up your image creations.
FROM openjdk:11-buster AS build-env-java
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-env
RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --no-install-recommends --assume-yes git && \
    mkdir -p /var/repository && \
    mkdir -p /kitdm20/
# prepare the environment for potential credentials
RUN mkdir /root/.ssh/ && \
    touch /root/.ssh/known_hosts && \
    git config --global user.name "docker" && \
    git config --global user.email docker@docker.docker


# This is the building environment and contains your ssh key!
# The label shall remember you and help to remove all images with credentials.
FROM build-env-java as build-indexer
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-contains-credentials
ARG SSH_PRIVATE_KEY
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    eval $(ssh-agent -s) && \
    ssh-add ~/.ssh/id_rsa && \
    ssh-keyscan -t rsa git.scc.kit.edu >> /root/.ssh/known_hosts
# Run the compilation at image cration time, this is important.
# Use ssh for private repos (the key makes this easy), but https for public ones.
RUN cd /kitdm20/ && \
    git clone -v git@git.scc.kit.edu:on3151/indexing-service.git service && \
    cd service && \
    ./gradlew -Pclean-release build && \
    mv $(ls build/libs/*.jar) build/libs/indexer.jar && \
    cp build/libs/indexer.jar ../


# Note that this container does not derive from the other ones!
# This is a clean container. No credentials, no source, no apt usage!
# Only a run script, the binary and the configuration file will be there.
# Keeps image size small, and the image may be released to the public.
FROM openjdk:11-buster as run-indexer
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
RUN mkdir -p /kitdm20/config
COPY --from=build-indexer /kitdm20/indexer.jar /kitdm20/
COPY --from=build-indexer /kitdm20/service/src/main/resources/mytemplate.hbs /kitdm20/
COPY indexer/conf/application.properties /kitdm20/config/application.properties
EXPOSE 8080
CMD java -jar /kitdm20/indexer.jar
