#!/bin/bash

cd $HOME/prysm && $HOME/bin/bazel run //validator:validator accounts create -- --keystore-path=$HOME/prysm --password 12345678 2>&1 | tee $HOME/deposit_data_info_for_prylabs_dot_net.txt
