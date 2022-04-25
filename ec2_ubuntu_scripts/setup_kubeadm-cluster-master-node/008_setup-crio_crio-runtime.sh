#!/bin/bash
#CRI-O
######
#https://github.com/cri-o/cri-o/blob/main/install.md#apt-based-operating-systems
#APT based operating systems
#Note: this tutorial assumes you have curl and gnupg installed
#
To install on the following operating systems, set the environment variable $OS as the appropriate field in the following table:
#
#Operating system	$OS
#Debian Unstable	Debian_Unstable
#Debian Testing	Debian_Testing
#Debian 10	Debian_10
#Raspberry Pi OS	Raspbian_10
#Ubuntu 20.04	xUbuntu_20.04
#Ubuntu 19.10	xUbuntu_19.10
#Ubuntu 19.04	xUbuntu_19.04
#Ubuntu 18.04	xUbuntu_18.04

#To run as root....

export OS=`lasb-release -rs`

#If installing cri-o-runc (recommended), you'll need to install libseccomp >= 2.4.1. NOTE: This is not available in distros based on Debian 10(buster) or below, so buster backports will need to be enabled:

echo 'deb http://deb.debian.org/debian buster-backports main' > /etc/apt/sources.list.d/backports.list
apt update
apt install -y -t buster-backports libseccomp2 || apt update -y -t buster-backports libseccomp2
#And then run the following as root:
VERSION=1.23.4
echo "deb [signed-by=/usr/share/keyrings/libcontainers-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb [signed-by=/usr/share/keyrings/libcontainers-crio-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list

mkdir -p /usr/share/keyrings
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | gpg --dearmor -o /usr/share/keyrings/libcontainers-archive-keyring.gpg
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/Release.key | gpg --dearmor -o /usr/share/keyrings/libcontainers-crio-archive-keyring.gpg

sudo apt update
sudo apt install cri-o cri-o-runc
#Note: We include cri-o-runc because Ubuntu and Debian include their own packaged version of runc. While this version should work with CRI-O, keeping the packaged versions of CRI-O and runc in sync ensures they work together. If you'd like to use the distribution's runc, you'll have to add the file:

[crio.runtime.runtimes.runc]
runtime_path = ""
runtime_type = "oci"
runtime_root = "/run/runc"
to /etc/crio/crio.conf.d/

echo "[crio.runtime.runtimes.runc]" | sudo tee -a /etc/crio/crio.conf.d/
echo "runtime_path = \"\"" | sudo tee -a /etc/crio/crio.conf.d/
echo "runtime_type = \"oci\"" | sudo tee -a /etc/crio/crio.conf.d/
echo "runtime_root = \"/run/runc\"" | sudo tee -a /etc/crio/crio.conf.d/
