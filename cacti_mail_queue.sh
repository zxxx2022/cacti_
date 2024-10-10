#!/bin/sh

# script for monitoring FreeBSD in cacti monitoring tool
# Author: Petr Macek (petr.macek@kostax.cz)
# v. 0.3

# for monitoring sendmail or postfix mail queues

# Expects 1 parameter

# Posibilities of first parameter:
# client - return number of emails in client queue
# mail - return number of emails in mail queue

# Return value or negative number when error occurs

# Requirements !!!
# -

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# sendmail or postfix?
XMAILER=`grep mailq /etc/mail/mailer.conf | cut -f 3`
if [ $XMAILER = "/usr/local/sbin/sendmail" ]
then
	XMAILER=postfix
fi

if [ $# -eq 1 ]
then

	case "$1" in
  		client)
			if [ $XMAILER = "postfix" ] 
			then 
				echo 0
			else	#sendmail
				mailq -Ac | tail -1 | cut -d' ' -f 3
			fi
	    ;;

	    mail)
			if [ $XMAILER = "postfix" ] 
			then
				mailq -Ac | tail -1 | cut -d' ' -f 5
			else
				mailq  | tail -1 | cut -d' ' -f 3
			fi
	    ;;
    
	    *)
			echo -1
	    ;;
	esac

else    # incorrect count of parameters 
  echo -2
fi
        
