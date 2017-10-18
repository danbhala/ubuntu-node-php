FROM giacomofurlan/php:7.1-alpine

ARG NODE_VERSION=8.7.0

LABEL php_version=7.1.10
LABEL node_version=$NODE_VERSION

RUN apk add --no-cache \
  bash coreutils tar \
  make gcc g++ python \
  linux-headers binutils-gold \
  gnupg libstdc++

RUN cd /tmp \
  && curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz > nodejs-src.tar.gz \
  && tar xf nodejs-src.tar.gz \
  && cd node-v${NODE_VERSION} \
  && ./configure --prefix=/usr \
  && make -j`getconf _NPROCESSORS_ONLN` \
  && make install
RUN rm -rf /tmp/*

# Yarn
RUN npm install -g yarn

CMD ["bash"]
