#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring (ipfw, ipf, pf) denied packets

# Expects 1 parameter

# Posibilities of first parameter:
# ipfw - V input
# ipf - Load in %
# pf - Battery charge

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ]
then

	case $1 in 
		ipfw)
			ipfw -a list 2>/dev/null | egrep "deny|reset|unreach" | awk 'BEGIN {sum=0; } {  sum += $2; } END { print sum }'	
		;;
		ipf)	

			ipfstat -nhio 2>/dev/null | egrep "block" | awk '{  sum += $1; } END { print sum }'	
		;;
		pf)
			pfctl -sr -v | awk 'BEGIN {sum=0;} {if (/^block/) { getline; sum += $5; } } END {print sum}'
		;;
		*)
			echo -1
		;;
	esac
else	# incorrect count of parameters 
	echo -2
fi

