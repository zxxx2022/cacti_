#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring users

# Expects 1 parameter (only for users with UID > 999)

# Posibilities of first parameter:
# total - return number of users in system
# logged - return number of users logged in system
# nopassword - return number of users without password 

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ] 
then
  case "$1" in
    total)
	cat /etc/passwd | cut -d":" -f3 | grep -e "^[0-9]\{4,6\}$" | wc -l
    ;;
    
    logged)
	who | wc -l
    ;;

    nopassword)
    	awk -F: 'NF > 1 && $1 !~ /^[#+-]/ && $2=="" {print $0}' /etc/master.passwd | wc -l
	;;
    
    *)
	  echo -1
    ;;
  esac
else
  echo -2
fi
