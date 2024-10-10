#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring installed ports

# Expects 1 parameter

# Posibilities of first parameter:
# total - return number of installed ports
# vulnerability - return number of broken ports
# old - return number of old ports 

# Return value or negative number when error occurs

# Requirements !!!
# installed portaudit (for vulnerability)

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ]
then
  case "$1" in
    total)
	pkg info | wc -l
    ;;

    old)
        pkg version -I | grep -e "<" | wc -l
    ;;


    vulnerability)
        pkg audit | grep problem\(s\) | cut -d " " -f 1
    ;;
    
    *)
	echo -1
    ;;
  esac
else
  echo -2
fi

