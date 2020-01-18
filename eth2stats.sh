#!/bin/sh

#This will stop any currently running docker image for ethstats
docker stop eth2stats
docker rm eth2stats

#Update the image
docker pull alethio/eth2stats-client:latest

#start/restart the image
docker run -d --name eth2stats --restart always --network="host" \
      -v ~/eth2stats/data:/data \
      alethio/eth2stats-client:latest \
      run --v \
      --eth2stats.node-name="superphiz" \
      --data.folder="$HOME/prysm" \
      --eth2stats.addr="grpc.sapphire.eth2stats.net:443" \
      --beacon.metrics-addr="http://localhost:8080/metrics" \
      --eth2stats.tls=true \
      --beacon.type="prysm" --beacon.addr="localhost:4000"
