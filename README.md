# prysmatic_setup

## These scripts modify critical system files and should only be used on a testing machine!

These scripts are intended to take a clean Ubuntu 18.04 target (server or desktop) and install the prysmatic beacon chain and validator clients.

They will also generate an Ethereum2 wallet address which will display on screen and be saved in the user's home directory.

After setup, upon reboot, two screen instances are launched, "beacon" and "validator". You can interact with these by typing "screen -x validator" and "screen -x beacon" in a terminal. To exit a screen instance, hold the CTRL key and type "A" then "D".

These scripts will also rebuild and restart the beacon chain and validator if they are crashed or exit. To rebuild or restart a service, enter the screen session and type "CTRL C" once to kill the process, it will respawn.


Steps for use:

1. Install Ubuntu 18.04 on a clean target as a desktop or server. (You can use a virtual machine!)
2. Open a terminal and run these commands: 

    git clone https://github.com/superphiz/prysmatic_setup
    
    cd prysmatic_setup
    
    ./setup.sh
    
3. You will be asked to enter your root password, note that these scripts are only for testing and have no access to real value. You should NOT run these scripts on your daily driver computer because they alter a system file (/etc/rc.local).

4. The information to launch the node will be displayed on the screen AND saved in a file in the home directory.

5. When you reboot the computer the beacon chain and validator will build and launch automatically, but they will be invisible until you access them through the "screen -x" command.
