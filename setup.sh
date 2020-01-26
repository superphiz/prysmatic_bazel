#!/bin/bash

#2019-06-06 based on https://github.com/prysmaticlabs/prysm
#2020-01-25 considering it mostly done, now is fully automated install and launch of goerli geth, beacon chain, validator, and eth2stats.

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

#update the system
sudo apt update && sudo apt dist-upgrade -y

#install dependencies for bazel, expect is to add the unbuffer command to allow colorful text piping
sudo apt install -y pkg-config zip g++ zlib1g-dev unzip python expect git curl screen


#Adding to the docker group is necessary for eth2stats to run.
groups `id -un -- 1000`| grep docker
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo You are in the docker group, cool beans.
else
  #Add the user to docker
  sudo groupadd docker
  sudo usermod -aG docker `id -un -- 1000`
  #give a notice then terminate the script beacuse they're not ready
  echo "You are NOT in the docker group I\'m adding you, but you MUST exit and log back in and restart this script. \(Sorry, it has to be this way\)"
  echo "REBOOT and relaunch setup.sh"
  echo "REBOOT and relaunch setup.sh"
  echo "REBOOT and relaunch setup.sh"
  exit 1
fi


#check for docker and install it if necessary
which docker
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo docker is installed
else
  echo docker is not installed

  #download the docker installer
  curl -fsSL https://get.docker.com -o get-docker.sh

  #install docker
  sudo sh get-docker.sh
fi

#launch the stats monitor
$HOME/prysmatic_bazel/eth2stats.sh


#user 1000 (main user) needs to reboot without password:
sudo sh -c "echo \"`id -un -- 1000` ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff\" >> /etc/sudoers"

#add ethereum repository for geth
sudo add-apt-repository -y ppa:ethereum/ethereum

#install geth
sudo apt install -y geth

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

#bazel command completion
echo "source $HOME/.bazel/bin/bazel-complete.bash" >> $HOME/.bashrc

#sourcing all of this now so it goes into effect immediately. 
source $HOME/.bashrc

#permissions got jacked for the git repo, won't hurt to set all home permissions
sudo chown -R `id -un -- 1000`:`id -un -- 1000` ~/
sudo chown -R `id -un -- 1000`:`id -un -- 1000` ~/.*
sudo chown -R root:root /home/staker/.cache/bazel/_bazel_root

#cloning the prysmatic client
cd $HOME && git clone https://github.com/prysmaticlabs/prysm

#adding screen start jobs at boot
sudo cp $HOME/prysmatic_bazel/rc.local /etc/

#starting screen jobs now
/bin/su `id -un -- 1000` -c "/usr/bin/screen -dmS beacon-screen  bash -c '/home/`id -un -- 1000`/prysmatic_bazel/beacon_chain_restarter.sh; exec bash'"
/bin/su `id -un -- 1000` -c "/usr/bin/screen -dmS validator-screen  bash -c '/home/`id -un -- 1000`/prysmatic_bazel/validator_restarter.sh; exec bash'"
/bin/su `id -un -- 1000` -c "/usr/bin/screen -dmS geth  bash -c '/home/`id -un -- 1000`/prysmatic_bazel/launch_geth.sh; exec bash'"

cd $HOME && $HOME/prysmatic_bazel/create_wallet.sh

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
printf "${RED}READ THE FOLLOWING TEXT FOR SHURE LEGIT PLZ.\n${NC}"

printf "${YELLOW}\n\nThe basic setup is done. It looks like nothing is happening, but everything is currently syncing in the background. \n\nCopy the message and use it to send the transaction from https://alpha.prylabs.net/participate. \n\nYou can now access three screen sessions accessible by 'screen -ls' that will show 'beacon-screen', 'validator-screen' and 'geth'.\n\n${NC}"

#show running screens
/bin/su `id -un -- 1000` -c "screen -ls"

printf "${YELLOW}\nYou can enter any of the screens above by typing something like \"screen -x beacon-screen\". To EXIT that screen session, hold [CTRL] and press A, then D.\n\n When you reboot this computer those tools will run in the background with screen.\n\n"

