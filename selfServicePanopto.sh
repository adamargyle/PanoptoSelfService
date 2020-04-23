#!/bin/bash
# 2020-04-15
# adds permissions to the current user's home folder to the panopto upload user

currentuser="$3"
if [[ -z $currentuser ]]; then
	currentuser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
fi

chmod +a "panopto_upload:allow:execute" /Users/$currentuser/
chmod +a "panopto_upload:allow:read" /Users/$currentuser/
exit