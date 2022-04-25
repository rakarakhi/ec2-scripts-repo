#!/bin/bash

if [[ $1 == '-h' ]] || [[ $1 == '/h' ]] || [[ $1 == '/help' ]] || [[ $1 == '-help' ]] || [[ $1 == '--help' ]] || [[ $1 == 'help' ]];
then
	echo "Help: This command installs all pending update on ${HOSTNAME}"
	echo "In Command Prompt Just execute: $0"
	exit 0
elif [[ $1 != '' ]];
then
	echo "Invalid argument..."
	echo "To get help: Type $0 -h | /h | /help | -help | --help | help"
	exit 1
else
	echo "System wull be updated now..."
	echo "System details..."
	hostnamectl
	echo ""
	echo "Updating Package Lists..."
	sleep 5
        sudo apt update
	echo "Upgrading Packages..."
        sleep 5
        sudo apt upgrade -y
	echo ""
	echo ""
	echo "System is up-to-date..."
	exit 0
fi


