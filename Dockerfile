ARG UBUNTU_VERSION=16.04
FROM ubuntu:$UBUNTU_VERSION

ARG DOCKER_VERSION=18.09.9
ARG DOCKER_COMPOSE_VERSION=1.26.2


# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install git repo to get higher git version
RUN apt-get update \
        && apt-get install -y software-properties-common \
        && add-apt-repository ppa:git-core/ppa

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl3 \
        libicu55 \
        libunwind8 \
        netcat

# Install docker, we don't use the apt repository, 
# * because this would install no specifc version
# * because this would install the daemon too
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
        | tar zxvf - --strip 1 -C /usr/bin docker/docker

# Install docker-compose
# The package in the standard ubuntu repo just contains docker-compose version 1.8.0, which is way too old,
# So we install it manually with curl

RUN curl -fsSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/bin/docker-compose \
        && chmod +x /usr/bin/docker-compose

# Print info
RUN docker --version && docker-compose --version

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]