FROM ubuntu:22.04

ARG PLATFORM=amd64
ARG NODE_VERSION=24.20.0

ENV PATH="/usr/local/nodejs/bin:${PATH}"

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN \
    wget https://github.com/jqlang/jq/releases/download/jq-1.8.2/jq-linux-$PLATFORM -O /usr/local/bin/jq && chmod +x /usr/local/bin/jq && \
    pip install yq && \
    wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz && \
    tar -xf node-v$NODE_VERSION-linux-x64.tar.xz && \
    mv node-v$NODE_VERSION-linux-x64 /usr/local/nodejs && \
    curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/$PLATFORM/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl
    

WORKDIR /root

ENTRYPOINT ["/bin/bash"]