#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring ntpd

# Expects 1 parameter

# Posibilities of first parameter:
# rootdispersion - return rootdispersion 
# offset - return offset 
# jitter - return jitter 

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ]
then
  case "$1" in
    rootdispersion)
    	#ntpq -c rv | grep rootdispersion | cut -d "=" -f 4 | cut -d "," -f1
		ntpq -c rv | grep disper | awk ' {  match ($0,"rootdispersion=[0-9\.]+")} END {print substr ($0,RSTART+15,RLENGTH-15)}'
    ;;
	
    jitter)
    	#ntpq -c rv | grep jitter | cut -d "=" -f 4 | cut -d "," -f1
    	ntpq -c rv | grep jitter | awk ' {  match ($0,"jitter=[0-9\.]+")} END {print substr ($0,RSTART+7,RLENGTH-7)}'
    	

    ;;
	
    offset)
		#ntpq -c rv | grep offset | cut -d "=" -f 2 | cut -d "," -f1
		ntpq -c rv | grep offset | awk ' {  match ($0,"offset=[0-9\.]+")} END {print substr ($0,RSTART+7,RLENGTH-7)}'
	;;
    
    *)
	  echo -1
    ;;
  esac
else
  echo -2
fi







