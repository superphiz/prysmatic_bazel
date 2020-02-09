#!/bin/bash

#NOTE:The first time you run this it's going to take an eternity to build cmake, just wait. Like, more than ten minutes.

while true
do
	cd $HOME/prysm && /usr/bin/git gc --prune=now
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //beacon-chain:beacon-chain --define=kafka_enabled=false
	cd $HOME/prysm && $HOME/bin/bazel run //beacon-chain -- --datadir=$HOME/prysm --p2p-host-ip=$(curl -s v4.ident.me) --p2p-max-peers=100 --peer=/dns4/api.attestant.io/tcp/13000/p2p/16Uiu2HAmAsyW714qpiYz9dNEoDyLa29SuzXwU4sY3fQrRtUxN1bT
done

