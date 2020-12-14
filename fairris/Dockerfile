FROM rust:1-buster AS rust-base
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-env
RUN apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --no-install-recommends --assume-yes \
        ca-certificates curl git ssh && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh 


FROM rust-base as fairris-build
LABEL maintainer="pfeil@kit.edu"
LABEL stage=build-contains-credentials
RUN echo "NOTE: Compiling will take a while." && \
    mkdir -p /repo/ && \
    cd repo && \
    git clone --recursive https://github.com/Pfeil/Fairris.git --branch=master && \
    cd Fairris && \
    bash build.sh


# clean image
FROM nginx:stable-alpine AS fairris
LABEL maintainer="pfeil@kit.edu"
LABEL stage=run
COPY --from=fairris-build /repo/Fairris/static/* /usr/share/nginx/html/