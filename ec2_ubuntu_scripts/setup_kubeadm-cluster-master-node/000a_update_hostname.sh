#!/bin/bash
#Take hostname as $1

if [[ $1 == '' ]];
then
	echo "hostname not provided"
	echo "$0 'hostname'"
	exit -1
else
	echo "hostname is: $1"
	#exit 0
fi
sudo hostnamectl set-hostname $1
#
###Get internal IP
##
## "echo <IP_Address>	$1" >> sudo /etc/hosts
export local_ipv4=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "$local_ipv4   $1" | sudo tee -a /etc/hosts
