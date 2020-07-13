FROM ubuntu:latest AS rust-base
LABEL maintainer="pfeil@.kit.edu"
LABEL stage=build-env
RUN apt update && \
    apt install --no-install-recommends -y \
    ca-certificates curl file \
    build-essential git ssh \
    autoconf automake autotools-dev libtool xutils-dev && \
    rm -rf /var/lib/apt/lists/*
# prepare the environment for potential credentials
RUN mkdir /root/.ssh/ && \
    touch /root/.ssh/known_hosts && \
    git config --global user.name "docker" && \
    git config --global user.email docker@docker.docker
# install stable rust and wasm-pack
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y
ENV PATH=/root/.cargo/bin:$PATH
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh 


FROM rust-base as fairris-build
LABEL maintainer="pfeil@.kit.edu"
LABEL stage=build-contains-credentials
ARG SSH_PRIVATE_KEY
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    eval $(ssh-agent -s) && \
    ssh-add ~/.ssh/id_rsa
RUN ssh-keyscan -t rsa git.scc.kit.edu >> /root/.ssh/known_hosts
# Run the compilation at image cration time, this is important.
# Use ssh for private repos (the key makes this easy), but https for public ones.
RUN echo "NOTE: Compiling will take a while." && \
    mkdir -p /repo/ && \
    cd repo && \
    git clone --recursive git@git.scc.kit.edu:on3151/fairris.git --branch=router && \
    cd fairris && \
    bash build.sh


# clean image
FROM nginx:stable-alpine AS fairris
LABEL maintainer="pfeil@.kit.edu"
LABEL stage=run
COPY --from=fairris-build /repo/fairris/static/* /usr/share/nginx/html/
EXPOSE 8080