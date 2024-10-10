#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring uptime

# without parameter

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 0 ]
then
  # uptime in days
  BOOT=`sysctl kern.boottime | cut -d "," -f 1 | cut -d"=" -f2`
  NOW=`date +%s`
  echo "($NOW - $BOOT)/86400" | bc
else
  echo -1
fi



