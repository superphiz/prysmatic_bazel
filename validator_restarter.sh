#!/bin/bash

while true
do
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //validator:validator
	cd $HOME/prysm && $HOME/bin/bazel run validator -- \
	--datadir=$HOME/.eth2validators \
	--password="12345678" \
	--graffiti="superphiz" \
	2>&1 | tee -a $HOME/validator.log
done
