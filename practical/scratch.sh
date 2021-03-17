#!/bin/bash

: '


Usage:
	./scriptname.sh <ticket-id>

	@ticket-id - the JIRA ticket ID in lowercase e.g. mt-3070
'

PROJECT_DIR=



cd ~/projects/@amaysim.com.au/mobile-bss;

VERSION=`cat meta.json | /usr/local/bin/jq ".version" | sed 's;";;g'`
TICKET_ID=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | sed -e 's;feature/;;g' | sed -r 's/([[:alnum:]]-[[:digit:]]+).*/\1/'`
DEPLOY_BUCKET=`osascript -e 'osascript -e 'set config to load script file ((path to home folder as text) & "applescript:lib:config.scpt")' -e 'getCategoryValue("bss", "Deployment Bucket") of config'`


FULL_LOCATION="s3://repo-sydney-amaysim/app/compass-gateway/$VERSION/compass-gateway-$VERSION-$TICKET_ID-SNAPSHOT.zip"

echo `pwd`
echo $VERSION
echo $FULL_LOCATION

aws s3 ls $FULL_LOCATION 1> /dev/null

exit_status=$?
echo "Exit status: $exit_status"

if [ $exit_status == 0 ]; then
	echo "Success"
else
	echo "Error"
fi
