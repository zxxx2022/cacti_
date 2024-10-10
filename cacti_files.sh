#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring total and openned files

# Expects 1 parameter

# Posibilities of first parameter:
# maxfiles - return sysctl kern.maxfiles 
# openned - return number of openned files 

# Return value or negative number when error occurs

# Requirements !!!
# -  

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ]
then
	case "$1" in
	  maxfiles)
		sysctl kern.maxfiles | cut -d ":" -f 2	
      ;;
    
	  openned)
		fstat | wc -l	
  	  ;;

  	  *)	# bad parameter
		echo -1
  	  ;;
	esac
else
  echo -2	# incorrect count of parameters
fi
