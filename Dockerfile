FROM ubuntu:16.04
MAINTAINER Stepan Kuzmin <to.stepan.kuzmin@gmail.com>

ENV OSRM_VERSION 5.4.2

RUN apt-get -yqq update \
  && apt-get -yqq install \
  build-essential \
  cmake \
  curl \
  git \
  libboost-all-dev \
  libbz2-dev \
  liblua5.1-0-dev \
  libluabind-dev \
  libstxxl-dev \
  libstxxl1v5 \
  libtbb-dev \
  libxml2-dev \
  libzip-dev \
  lua5.1 \
  pkg-config

RUN mkdir -p /usr/src/osrm-backend/build \
  && curl -SLO "https://github.com/Project-OSRM/osrm-backend/archive/v$OSRM_VERSION.tar.gz" \
  && tar xzf "v$OSRM_VERSION.tar.gz" --strip-components 1 -C /usr/src/osrm-backend \
  && rm "v$OSRM_VERSION.tar.gz" \
  && cd /usr/src/osrm-backend/build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && cmake --build . \
  && cmake --build . --target install \
  && mkdir /data \
  && cp -r /usr/src/osrm-backend/profiles /data

COPY entrypoint.sh /data/entrypoint.sh
COPY profiles/* /data/profiles

EXPOSE 5000
VOLUME /data

ENTRYPOINT ["/data/entrypoint.sh"]
CMD ["bash", "entrypoint.sh"]
