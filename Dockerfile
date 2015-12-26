# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# We start with the phusion base image since it gets us a builtin, pre-configured
# daemon manager (runit) and a logging framework (syslog-ng) for free
FROM phusion/baseimage:0.9.18
MAINTAINER LeisureLink Tech <techteam@leisurelink.com>
# The original, in a private LeisureLink repository was Michael Hughes <mhughes@leisurelink.com>

# NOTE: We downgrade the npm to version 2.11.2 because it propagates the correct
#       rights when accessing private packages via a git+ssh reference.
ENV NODE_VERSION=0.12.7 \
    NPM_VERSION=2.11.2

ADD https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz /tmp/node-v${NODE_VERSION}-linux-x64.tar.gz

RUN set -ex && \
  cd /tmp && \
  tar -xzf /tmp/node-v${NODE_VERSION}-linux-x64.tar.gz -C /usr/local --strip-components=1 && \
  npm install -g npm@${NPM_VERSION} && \
  npm cache clear && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
         /var/tmp/* \
         /tmp/*
