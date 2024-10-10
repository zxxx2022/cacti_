#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring mailstats

# expect 3 parameter (case insensitive), posibilities:

# Posibilities of first parameter:
# (direction)  from,to - returns number of emails 

# Posibilities of second parameter:
# (what) count,bytes - return number of emails or transferred kilobytes 

# Posibilities of third parameter:
# (mailer) local, smtp - smtp = smtp+esmtp

# returns number of emails/kbytes or negative number where error occurs

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [ $# -eq 3 ]
then

    if (( [ $1 = "from" ] || [ $1 = "to" ] ) && 
        ( [ $2 = "count" ] || [ $2 = "bytes" ] ) && 
        ( [ $3 = "local" ] || [ $3 = "smtp" ] ) 
       )
    then
	if [ $1 = "from" ]
	then 
	    COL=3
	else 
	    COL=5
	fi
	
	if [ $2 = "bytes" ]
	then 
	    COL=`expr $COL + 1`
	fi
	
	if [ $3 = "local" ]
	then	    
    	    POM=`mailstats -P | grep local | tr -s " " | cut -d" " -f $COL`
    	    if [ $2 = "bytes" ] 
    	    then
    		    echo `expr $POM \* 1024`
    	    else
        	    echo $POM
    	    fi
    	else
    	    POM=`mailstats -P | grep smtp | tr -s " " | cut -d" " -f $COL | awk 'BEGIN {sum=0; } {  sum += $1; } END { print sum }'`
    	    if [ $2 = "bytes" ] 
    	    then
    		    echo `expr $POM \* 1024`
    	    else
        	    echo $POM
    	    fi
    	
    	fi
    else
      echo -1  		# incorrect parameters
    fi

else
	echo -2 	# incorrect count of parameters
fi

