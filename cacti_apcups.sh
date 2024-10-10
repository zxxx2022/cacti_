#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring apcupsd

# Expects 1 parameter

# Posibilities of first parameter:
# linev - V input
# loadpct - Load in %
# bcharge - Battery charge
# timeleft - timeleft
# itemp - temperature in celsius

# Return value or negative number when error occurs

# Requirements !!!
# installed apcupsd and uncomment and change this in /usr/local/etc/apcupsd.conf:
# STATTIME 900
# STATFILE /var/log/apcupsd.status
# (recomendation) LOGSTATS off

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

STATUSFILE="/var/log/apcupsd.status"

if [ $# -eq 1 ]
then
	case $1 in 
		linev|loadpct|bcharge|timeleft|itemp)

			if [ -e $STATUSFILE ]
			then
				res=`grep -i -e"^$1" $STATUSFILE | awk '{print $3}'`
				if [ -n "$res" ]
				then
					echo $res 
				else
					echo -1 
				fi
			else	# status file doesn't exist
			  echo -2
			fi
		;;

		*) # incorrect parameter
			echo -3
		;;
	esac
else	# incorrect count of parameters 
	echo -4
fi

