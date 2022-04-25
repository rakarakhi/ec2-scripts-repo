#!/bin/bash
#
echo "###Installing Jenkins and Java on System ${HOSTNAME}..."
echo ""
hostnamectl
sleep 5
clear
#
sudo apt update && sudo apt upgrade -y
#
## Install java
sudo apt install openjdk-11-jdk -y
#
## Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
#
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
#
sudo apt update && sudo apt install jenkins -y
# 
echo "Installation Complete..."
echo ""
echo "Starting Services..."
#Starting Jenkins
sudo systemctl start jenkins
#
#Configure Jenkins to start at boot
sudo systemctl enable jenkins
#
#Checking status of jenkins
sudo systemctl status jenkins
#
#Will show below output if everything is working fine:
#Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
#Active: active (running) since Tue 2018-11-13 16:19:01 +03; 4min 57s ago



