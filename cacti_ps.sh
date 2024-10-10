#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring processes

# Expects 1 parameter

# Posibilities of first parameter:
# total - return number of processes
# d/i/l/r/s/t/w/z - return number of processes in specific state [man ps, section state]

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 1 ] 
then
  case "$1" in
    total)
	ps ax | wc -l
    ;;
    [Dd])
        ps ax | cut -c 12 | grep D | wc -l
    ;;
    [Ii])
        ps ax | cut -c 12 | grep I | wc -l
    ;;
    [Ll])
        ps ax | cut -c 12 | grep L | wc -l
    ;;
    [Rr])
        ps ax | cut -c 12 | grep R | wc -l
    ;;
    [Ss])
        ps ax | cut -c 12 | grep S | wc -l
    ;;
    [Tt])
        ps ax | cut -c 12 | grep T | wc -l
    ;;
    [Ww])
        ps ax | cut -c 12 | grep W | wc -l
    ;;
    [Zz])
        ps ax | cut -c 12 | grep Z | wc -l
    ;;

    *)
	  echo -1
    ;;
  esac
else
  echo -2
fi
