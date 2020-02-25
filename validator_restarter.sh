#!/bin/bash

while true
do
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //validator:validator
	cd $HOME/prysm && $HOME/bin/bazel run validator -- \
	--datadir=$HOME/.eth2validators \
	--password="12345678" \
	--graffiti="73757065727068697A" \
	2>&1 | tee $HOME/prysm/validator.log
done
