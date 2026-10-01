#!/bin/bash

TIME_MACHINE_VERSION="V1"
SAVED_DATE=""

if [ "$1" == "" ]
then
	echo "Bad usage. Use --help"
	exit 1
fi

if [ "$1" == "--help" ]
then
	echo "Time Machine $TIME_MACHINE_VERSION"
	echo "./time_machine [Date] [Filename] [Username]"
	exit 0
fi

if [ "$(whoami)" != "root" ]
then
	echo "Insufficient permissions"
	exit 1
fi

if [ "$(timedatectl show --property=NTP --value)" == "yes" ]
then
	echo "Set-ntp is enabled."
	echo "This could be fixed by executing 'timedatectl set-ntp false'"
fi

SAVED_DATE="$(date)"
sudo date -s "$1"

touch "$2-tm"

echo "Copying file..."
cp "$2" "$2-tm"

sudo date -s "$1"
echo "$3"
sudo chown "$3":"$3" "$2-tm"

sudo date -s "$SAVED_DATE"
exit 0