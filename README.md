# OSRM Docker

[![Docker Stars](https://img.shields.io/docker/stars/stepankuzmin/osrm.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/stepankuzmin/osrm.svg)]()
[![Docker Automated buil](https://img.shields.io/docker/automated/stepankuzmin/osrm.svg)]()

```shell
docker run -d -p 5000:5000 stepankuzmin/osrm <url> <profile>
```

Where `url` is osm.pbf url and `profile` is one of the default OSRM profiles (`foot` is default).

You can also mount a host directory as a data volume:

```shell
docker run -d \
  -p 5000:5000 \
  -v /data:/data \
  --name osrm \
  stepankuzmin/osrm
```

This command mounts the host directory, `/data`, into the container at `/data`.

## Usage:

This will create docker container with mapzen extract processed using default car profile

```shell
docker run -d -p 5000:5000 stepankuzmin/osrm "https://s3.amazonaws.com/metro-extracts.mapzen.com/moscow_russia.osm.pbf" car
```

You can also set `sysctl` options for container with `--sysctl`

```shell
docker run \
  -d \
  -p 5000:5000 \
  --sysctl "kernel.shmmax=18446744073709551615"
  stepankuzmin/osrm "https://s3.amazonaws.com/metro-extracts.mapzen.com/moscow_russia.osm.pbf" car
```
