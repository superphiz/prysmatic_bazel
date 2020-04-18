#!/bin/sh

#If docker isn't installed... don't just uncomment this, it'll need to be step by step.

#   curl -fsSL https://get.docker.com -o get-docker.sh
#   sh get-docker.sh
#   sudo apt install -y docker-compose
#   sudo usermod -aG docker $USER



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
      --eth2stats.node-name="superphiz script" \
      --data.folder="$HOME/prysm" \
      --eth2stats.addr="grpc.topaz.eth2stats.io:443" --eth2stats.tls=true \
      --beacon.metrics-addr="http://localhost:8080/metrics" \
      --eth2stats.tls=true \
      --beacon.type="prysm" --beacon.addr="localhost:4000"
