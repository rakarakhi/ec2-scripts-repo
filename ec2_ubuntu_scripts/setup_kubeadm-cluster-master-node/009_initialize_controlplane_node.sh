#!/bin/bash
#Take hostname as $1
#run as root
echo ""
echo "Initialization..."
#
if [[ $USER != 'root' ]];
then
	echo "${USER} is not valid user to execute the ecript.."
	echo "This script must be executed as User: 'root'..."
	echo "Use 'sudo -i' to switch over to 'root'..."
	exit -1
fi
#
if [[ $1 == '' ]] || [[ ${HOSTNAME} == '' ]];
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
## "echo <IP_Address>   $1" >> sudo /etc/hosts
export local_ipv4=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "$local_ipv4   $1" | sudo tee -a /etc/hosts

kubeamd -init kubeadm init   --apiserver-advertise-address $local_ipv4  --apiserver-bind-port 6443  --control-plane-endpoint $local_ipv4 --pod-network-cidr "192.168.0.0/16" --upload-certs | tee kubeadm-init-1.out
