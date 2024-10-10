#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring sendmail maillog (for postfix/amavis, you must change patterns!)

# Expects 1 parameter

# Posibilities of first parameter:
# ham - returns number of hams 
# blocked - returns number of blocked spam emails
# blacklist - returns number of blocked by blacklist 
# undecided - returns number probably spams 
# grey - returns number of delayed messages
# greywhite - returns number of delayed messages

# Return value or negative number when error occurs

# Requirements !!!
# - 

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ] 
then
  case "$1" in
    ham)
	grep -c "X-Spam-Status: No" /var/log/maillog    
    ;;
    blocked)
	grep -c "Blocked by SpamAssassin" /var/log/maillog
    ;;
    blacklist)
	grep -c "Spam blocked see" /var/log/maillog
    ;;
    undecided)
    	grep -c "Milter change: header Subject" /var/log/maillog
    ;;
    grey)
 	grep -c "X-Greylist: Delayed for" /var/log/maillog  
    ;;
    greywhite)
   	grep -c "Sender IP whitelisted, not delayed" /var/log/maillog
    ;;
    *)
	  echo -1
    ;;
  esac
else
  echo -2
fi
