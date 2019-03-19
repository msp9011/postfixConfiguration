#!/bin/bash


### Edit the following credentials before start ###
GMAIL_ID=abc@gmail.com
GMAIL_PWD='abc2o17'
OUTLOOK_ID=abc@outlook.com
OUTLOOK_PWD='abc1234'
####################################################

PATH='/etc/postfix'


TEST=`/bin/cat $PATH/main.cf | /bin/grep smtp.gmail.com`

if [ "$TEST" != '' ]; then

	/bin/sed -i "s/smtp.gmail.com/outlook.office365.com/g" $PATH/main.cf
	/bin/sed -i "s/smtp.gmail.com/outlook.office365.com/g" $PATH/sasl_passwd
	/bin/sed -i "s/$GMAIL_ID/$OUTLOOK_ID/g" $PATH/sasl_passwd
	/bin/sed -i "s/$GMAIL_PWD/$OUTLOOK_PWD/g" $PATH/sasl_passwd

	/usr/sbin/postmap $PATH/sasl_passwd
	/bin/sed -i "s/$GMAIL_ID/$OUTLOOK_ID/g" $PATH/header_check
	/bin/sed -i "s/$GMAIL_ID/$OUTLOOK_ID/g" $PATH/sender_canonical_maps

	/etc/init.d/postfix restart

else 

		echo " postfix Gmail not configured"
	
fi

