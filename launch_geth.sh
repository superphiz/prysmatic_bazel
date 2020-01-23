#!/bin/bash

#sudo add-apt-repository -y ppa:ethereum/ethereum
#sudo apt install geth

geth --goerli --rpc --rpcaddr=127.0.0.1 --rpcport=8545 --ws --wsaddr=127.0.0.1 --wsport=8546
