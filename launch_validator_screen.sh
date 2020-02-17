#!/bin/bash
/usr/bin/screen -dmS validator-screen  bash -c '/home/`id -un -- 1000`/prysmatic_bazel/validator_restarter.sh; exec bash'

