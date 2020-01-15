#!/bin/bash

sleep 420

while true; do
	LEAKS=`tail -n 80 $HOME/prysm/validator.log | grep =- | wc -l`

	ZEROES=`tail -n 80 $HOME/prysm/validator.log | grep =0.00000000 | wc -l`

	FAILURE=`tail -n 80 $HOME/prysm/validator.log | grep TransientFailure | wc -l`

	UNKNOWN_STATUS=`tail -n 80 $HOME/prysm/validator.log | grep UNKNOWN_STATUS | wc -l`

	BALANCE=`tac $HOME/prysm/validator.log | head | grep delta | awk '{print $11}'`

	NOW=$(date +"%m-%d-%Y-%H:%M:%S")

	if [ $LEAKS -ge 7 ] || [ $ZEROES -ge 6 ] || [ $FAILURE -ge 27 ] || [ $UNKNOWN_STATUS -ge 27 ]
		then
			echo "$NOW ******** RESTART ********" >> $HOME/prysm/validator_fails.log
			sudo /sbin/reboot
			#pkill beacon-chain
			#pkill validator
	fi

	echo "$NOW leaks: $LEAKS     zeroes: $ZEROES      TransientFailure: $FAILURE      UNKNOWN_STATUS: $UNKNOWN_STATUS      $BALANCE"  >> $HOME/prysm/validator_fails.log
	sleep 48
done
