#!/bin/bash
# 2020-04-15
# Script to Clean uninstall Panopto based on information from panopto support

username="$3"
if [[ -z $username ]]; then
	username=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
fi
rm -rf /Applications/Panopto\ Recorder.app
rm -rf /Applications/Panopto.app
rm /Users/"$username"/Library/Preferences/com.panopto.mac.plist
rm -rf /Users/"$username"/Library/Caches/com.panopto.mac/
rm -rf /Users/"$username"/Library/Application\ Support/Panopto\ Recorder/
rm -rf /Users/"$username"/Movies/Panopto\ Recordings
bash /var/panopto/uninstall_panopto.sh
rm -rf  /var/panopto
exit