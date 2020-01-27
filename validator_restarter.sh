#!/bin/bash

while true
do
	cd $HOME/prysm && /usr/bin/git pull
	cd $HOME/prysm && $HOME/bin/bazel build //validator:validator
	cd $HOME/prysm && $HOME/bin/bazel run validator -- --keymanager=keystore 
done
