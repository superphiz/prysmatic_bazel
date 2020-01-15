docker pull alethio/eth2stats-client:latest

docker run -d --name eth2stats-client --restart always --network="host" \
    alethio/eth2stats-client:latest \
    run --v \
    --eth2stats.node-name="superphiz" \
    --eth2stats.addr="grpc.sapphire.eth2stats.net:443" --eth2stats.tls=true \
    --beacon.type="prysm" --beacon.addr="localhost:4000"
