# OSRM Docker

[![Build Status](https://travis-ci.org/stepankuzmin/osrm-docker.svg?branch=master)](https://travis-ci.org/stepankuzmin/osrm-docker)
[![Docker Stars](https://img.shields.io/docker/stars/stepankuzmin/osrm.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/stepankuzmin/osrm.svg)]()
[![Docker Automated buil](https://img.shields.io/docker/automated/stepankuzmin/osrm.svg)]()

[The Open Source Routing Machine](https://github.com/Project-OSRM/osrm-backend) is a high performance routing engine written in C++11 designed to run on OpenStreetMap data.

```shell
docker run -d -p 5000:5000 stepankuzmin/osrm <url> <profile>
```

Where `<url>` is osm.pbf url and `<profile>` is one of the [OSRM profiles](https://github.com/Project-OSRM/osrm-backend/tree/master/profiles) (`foot` is default) or one of above:

* stepless - default foot profile excluding `steps`.

## Usage:

This will create docker container with mapzen extract processed using default car profile

```shell
docker run -d -p 5000:5000 stepankuzmin/osrm "https://s3.amazonaws.com/metro-extracts.mapzen.com/moscow_russia.osm.pbf" car
```

You can also mount a host directory as a data volume:

```shell
docker run -d \
  -p 5000:5000 \
  -v /srv/osrm/data:/data \
  -v /srv/osrm/extracts:/extracts \
  -v /srv/osrm/profiles:/profiles \
  --name osrm \
  stepankuzmin/osrm
```

This command mounts the host directory, `/srv/osrm/data`, into the container at `/data`, `/srv/osrm/extracts` into `/extracts` and `/srv/osrm/profiles` into `/profiles`.

## Documentation

- [osrm-routed HTTP API documentation](https://github.com/Project-OSRM/osrm-backend/blob/master/docs/http.md)

Running a query on your local server:

```
curl http://127.0.0.1:5000/route/v1/driving/13.388860,52.517037;13.385983,52.496891?steps=true&alternatives=true
```
