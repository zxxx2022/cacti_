#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring established tcp connections

# Expects 1 parameter

# Posibilities of first parameter:
# total - returns number of established tcp connection 
# (port) - 21,22,25,80,110,143,443 - returns number of est. tcp conn on current port 

# Return value or negative number when error occurs

# Requirements !!!
#  - 

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq	1 ]
then
  case "$1" in
    total)
    	sockstat -4 -6 -c | wc -l
    ;;
    
	21|22|25|80|110|143|443)
		sockstat -4 -6 -c -p$1 | wc -l
    ;;

	*)
	  echo -1
    ;;
  esac
else
  echo -2
fi
