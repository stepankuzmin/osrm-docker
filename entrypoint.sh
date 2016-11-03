#!/bin/bash

# Usage:
#   ./entrypoint.sh <url> <profile>
#   ./entrypoint.sh "https://s3.amazonaws.com/metro-extracts.mapzen.com/moscow_russia.osm.pbf" foot

URL=$1
PBF=${URL##*/}
OSRM=${PBF%%.*}.osrm
PROFILE=${2:-foot}.lua

_sig() {
  kill -TERM $child 2>/dev/null
}

trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT

if [ ! -f $OSRM ]; then
  if [ ! -f $PBF ]; then
    curl $URL > /extracts/$PBF
  fi
  cd /data
  osrm-extract -p /profiles/$PROFILE /extracts/$PBF
  osrm-contract $OSRM
fi

osrm-routed $OSRM &
child=$!
wait "$child"
