#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring named

# Expects 1 parameter

# Posibilities of first parameter:
# request - return number of requests
# ans_succ - return number of successfull answers
# ans_auth - return number of authoritative answers
# ans_nonauth - return number of nonauthoritative answers

# Return value or negative number when error occurs

# Requirements !!!
# named configure with statistics-file "/var/stats/named.stats"; (default)

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

rndc stats 
STATUSFILE="/var/named/var/stats/named.stats"

if [ $# -eq 1 ] 
then

  if [ -e $STATUSFILE ]
  then

	case "$1" in
  	  request)
	    grep "IPv4 requests received" $STATUSFILE | tail -1 | awk '{print $1}'
  	  ;;
  	  ans_succ)
		grep "queries resulted in successful answer" $STATUSFILE | tail -1 | awk '{print $1}'
  	  ;;
  	  ans_auth)
		grep "queries resulted in authoritative answer" $STATUSFILE | tail -1 | awk '{print $1}'
  	  ;;
  	  ans_nonauth)
		grep "queries resulted in non authoritative answer" $STATUSFILE | tail -1 | awk '{print $1}'
  	  ;;
  	  *)
		echo -1
  	  ;;
	esac

	HOUR=`date '+%H'`
	MINUTE=`date '+%M'`

	if [ $HOUR -eq 23 ] && [ $MINUTE -gt 50 ]
	then
		`> $STATUSFILE`
  	fi
  else  # missing STATUSFILE
      echo -2
  fi
else	# incorrect count of parameters
  echo -3
fi
