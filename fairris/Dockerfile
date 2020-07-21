FROM rust:1-buster AS rust-base
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-env
RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --no-install-recommends --assume-yes \
        ca-certificates curl git ssh && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh 
# prepare the environment for potential credentials
RUN mkdir /root/.ssh/ && \
    touch /root/.ssh/known_hosts && \
    git config --global user.name "docker" && \
    git config --global user.email docker@docker.docker


FROM rust-base as fairris-build
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-contains-credentials
ARG SSH_PRIVATE_KEY
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    eval $(ssh-agent -s) && \
    ssh-add ~/.ssh/id_rsa && \
    ssh-keyscan -t rsa git.scc.kit.edu >> /root/.ssh/known_hosts
# Use ssh for private repos (the key makes this easy), but https for public ones.
RUN echo "NOTE: Compiling will take a while." && \
    mkdir -p /repo/ && \
    cd repo && \
    git clone --recursive git@git.scc.kit.edu:on3151/fairris.git --branch=master && \
    cd fairris && \
    bash build.sh


# clean image
FROM nginx:stable-alpine AS fairris
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
COPY --from=fairris-build /repo/fairris/static/* /usr/share/nginx/html/