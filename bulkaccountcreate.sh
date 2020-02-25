#!/bin/bash

read -p 'How many accounts do you want to create? ' ACCOUNTS

for i in $(seq 1 $ACCOUNTS)
do
	cd $HOME/prysm && $HOME/bin/bazel run //validator -- accounts create \
	--keystore-path=$HOME/.eth2validators \
	--password=12345678 \
	2>&1 | tee -a $HOME/deposit_data_info_for_prylabs_dot_net.txt
done

printf "\n\n All done, your keys should be stored in $HOME/keystore, and you'll find a file in the home directory with the deposit data. The default password for all of these accounts is 12345678.\n"
