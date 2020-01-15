#!/bin/bash

#2019-06-06 based on https://github.com/prysmaticlabs/prysm

#user 1000 (main user) needs to reboot without password:
sudo sh -c "echo \"`id -un -- 1000` ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff\" >> /etc/sudoers"

#install dependencies for bazel, expect is to add the unbuffer command to allow colorful text piping
sudo apt install -y git pkg-config zip g++ zlib1g-dev unzip python expect

#download bazel (this could be updated to pull the latest release!)
wget https://github.com/bazelbuild/bazel/releases/download/2.0.0/bazel-2.0.0-installer-linux-x86_64.sh

chmod +x bazel-2.0.0-installer-linux-x86_64.sh

./bazel-2.0.0-installer-linux-x86_64.sh --user

#bazel needs this path - this appears to be redundant because it is sourced later in this file.
export PATH="$PATH:$HOME/bin"

#addingthe path to bashrc for later boots
echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc

#colorful prompts are nice
echo 'force_color_prompt=yes' >> $HOME/.bashrc

#bazel command complation
echo "source $HOME/.bazel/bin/bazel-complete.bash" >> $HOME/.bashrc

#sourcing all of this now so it goes into effect immediately. 
source $HOME/.bashrc

#just checking the bazel version
bazel version

#cloning the prysmatic client
cd $HOME && git clone https://github.com/prysmaticlabs/prysm

sudo cp $HOME/prysmatic_setup/rc.local /etc/

cp $HOME/prysmatic_setup/*.sh $HOME/prysm/

cd $HOME/prysm && $HOME/prysm/create_wallet.sh

echo "The basic setup is done. copy the message and use it to send the transaction from https://alpha.prylabs.net/participate, and reboot this computer. When you reboot the server there should be two screen sessions accessible by 'screen -ls' that will show 'beacon' and 'validator'."
