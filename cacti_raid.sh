#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring raid (camcontrol or mptutil)

# Expects 1 parameter

# Posibilities of first parameter:
# (tool) - mptutil, camcontrol

# Posibilities of second parameter:
# (disk) - da0, da1, ...

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 2 ]
then
	case $1 in 
		mptutil)
		
			mptutil volume status $2 | grep "state: OPTIMAL" > /dev/null
			if [ $? -eq 0 ]
			then
				echo 1
			else
				echo 0
			fi
		;;
		camcontrol)
			camcontrol devlist | grep $2 | grep "VOLUME OK" > /dev/null
			if [ $? -eq 0 ]
			then
				echo 1
			else
				echo 0
			fi
		;;
		*)
			echo -1    	# incorrect parameters
		;;
	esac
else	# incorrect count of parameters 
	echo -2
fi

