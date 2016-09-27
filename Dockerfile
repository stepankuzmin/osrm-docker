FROM ubuntu:16.04
MAINTAINER Stepan Kuzmin <to.stepan.kuzmin@gmail.com>

ENV OSRM_VERSION 5.3.3

RUN apt-get -yqq update
RUN \
  apt-get -yqq install build-essential git cmake pkg-config \
  libbz2-dev libstxxl-dev libstxxl1v5 libxml2-dev \
  libzip-dev libboost-all-dev lua5.1 liblua5.1-0-dev libluabind-dev libtbb-dev curl

RUN mkdir -p /data
WORKDIR /data
RUN curl -OL "https://github.com/Project-OSRM/osrm-backend/archive/v$OSRM_VERSION.tar.gz"
RUN tar -xzf v$OSRM_VERSION.tar.gz
RUN rm v$OSRM_VERSION.tar.gz
RUN mkdir -p osrm-backend-$OSRM_VERSION/build
WORKDIR /data/osrm-backend-$OSRM_VERSION/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cmake --build .
RUN cmake --build . --target install
WORKDIR /data
RUN cp -r osrm-backend-$OSRM_VERSION/profiles /data/
RUN rm -rf /srv/galton/osrm-backend-$OSRM_VERSION

COPY entrypoint.sh entrypoint.sh

EXPOSE 5000
VOLUME /data

ENTRYPOINT ["/data/entrypoint.sh"]
CMD ["bash", "entrypoint.sh"]
