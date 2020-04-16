#!/bin/bash

#NOTE:The first time you run this it's going to take an eternity to build cmake, just wait. Like, more than ten minutes.

while true
do
	cd $HOME/prysm && /usr/bin/git gc --prune=now
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //beacon-chain:beacon-chain \
	cd $HOME/prysm && $HOME/bin/bazel run //beacon-chain -- \
		--datadir=$HOME/prysm \
		--p2p-host-ip=$(curl -s v4.ident.me) \
		--p2p-max-peers=100 \
		--p2p-tcp-port=13000 \
		--p2p-udp-port=12000 \
		--p2p-max-peers=200 \
done

