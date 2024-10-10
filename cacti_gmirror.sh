#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring gmirror raid 

# Expects 2 parameters

# Posibilities of first parameter:
# gm0, gm1, ... (provider)

# Posibilities of second parameter:
# total - returs number of disks in gmirror
# active - return number of active disks in gmirror

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 2 ]
then
	# gmirror loaded?
	res=`kldstat -n geom_mirror.ko 2>&1 `
	if [ $? -eq 0 ]
	then
		# good provider?
		res=`gmirror status $1 2>&1`
		if [ $? -eq 0 ]
		then
			case $2 in
				total)
					echo `gmirror list $1 | grep Compon | cut -d " " -f 2`
   				;;
				active)
   					echo `gmirror status -s $1 | wc -l` 
   				;;
				*)	# incorrect action
					echo -1
			esac
        else	# gmirror provider not exists
    	    		echo -2
    	fi
	else
		echo -3
	fi
else	# incorrect count of parameters 
	echo -4
fi
