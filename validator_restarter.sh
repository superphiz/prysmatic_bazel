#!/bin/bash

while true
do
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //validator:validator
	cd $HOME/prysm && unbuffer $HOME/bin/bazel run validator -- --datadir=/usr/local/prysm --password="12345678" 2>&1 | tee $HOME/prysm/validator.log
done
