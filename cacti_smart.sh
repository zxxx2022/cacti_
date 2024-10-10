#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring smart status of disks

# Expects 1 parameter

# Posibilities of first parameter:
# total - return number of disk in system
# error - return number of error 

# Return value or negative number when error occurs

# Requirements !!!
# installed smartmontool

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ]
then
  case "$1" in
    total)
        COUNT=0
        #egrep  -c "^ad[0-9]{1,2}:" /var/run/dmesg.boot 
        #egrep  "^ada?[0-9]{1,2}:" /var/run/dmesg.boot | cut -d ":" -f1 | sort | uniq | wc -l
        for F in `sysctl -n kern.disks`
        do
                if echo "$F" | grep -q cd; then
                        # skip cd/dvd   
                else
                        COUNT=`echo "$COUNT + 1" | bc`  
                fi
        done    
        echo $COUNT
    ;;
    
    error)
        ERROR=0         
        for F in `sysctl -n kern.disks`
        do
                if echo "$F" | grep -q cd; then
                        # skipt cd/dvd
                else
                        smartctl  -q silent -a /dev/$F 
                        X=`echo $?`
                        ERROR=`echo $X + $ERROR | bc`
                fi
        done
        echo $ERROR
    ;;

    *)
	  echo -1
    ;;
  esac
else
  echo -2
fi

  
