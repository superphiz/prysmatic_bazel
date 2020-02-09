#!/bin/bash

cd $HOME/prysm
for i in {1..100} #change 100 to your desired number of accounts
do
	bazel run //validator -- accounts create --keystore-path=$HOME/beacon-chain --password=changeme >> $HOME/beacon-chain/rawtxndata.txt
done
