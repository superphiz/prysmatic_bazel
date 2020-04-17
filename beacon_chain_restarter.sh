#!/bin/bash

while true
do
	cd $HOME/prysm && /usr/bin/git gc --prune=now
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //beacon-chain:beacon-chain
	cd $HOME/prysm && unbuffer $HOME/bin/bazel run //beacon-chain -- \
		--datadir=$HOME/prysm \
		--p2p-host-ip=$(curl -s v4.ident.me) \
		--p2p-max-peers=100 \
		--p2p-tcp-port=13000 \
		--p2p-udp-port=12000 \
		--p2p-max-peers=200 \
		 2>&1 | tee -a $HOME/beacon_chain.log
done

