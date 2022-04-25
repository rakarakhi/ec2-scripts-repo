#!/bin/bash
#
echo ""
echo "This Script [[ $0 ]] Updates Existing Packages and Installs AWS-CLI V2, VS Code and PowerShell..."
echo ""
sleep 10
echo "Update and upgrading existing packages..."
echo ""
sleep 5
sudo apt update && sudo apt upgrade -y
sudo apt install -y lsb-release
# Install AWS CLI V2
echo ""
echo "Install AWS CLI V2..."
echo ""
sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo "Which aws-cli?"
which aws
echo ""
echo "Which Version on AWS-CLI?"
aws --version
echo ""
echo "Clean up..."
rm -rf ./aws
rm -f ./awscliv2.zip
#
echo "AWS CLI V2 Installed..."
sleep 5
echo ""
# Install VS Code (code)
echo "Install VS Code (code)..."
echo ""
echo "Setting up repository..."
sleep 5
#
echo "Starting..."
sleep 5
#
sudo apt install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
#
echo "Repository Setup - Complete..."
sleep 5
echo "Installing VS Code"
sleep 5
echo "Starting installation..."
sleep 3
#
sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code
#
echo "Cleaning up..."
rm -f packages-microsoft-prod.deb*
echo "Installation of VS Code (code) Complete..."
sleep 10
echo ""
echo "Install Powershell for Linux..."
sleep 5
##Install Powershell
#Installation via Package Repository
#PowerShell for Linux is published to package repositories for easy installation and updates. The URL to the package varies by OS version:

##Ubuntu 20.04 - https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
##Ubuntu 18.04 - https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Update the list of packages
sudo apt update
sudo apt upgrade -y
# Install pre-requisite packages.
sudo apt install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
# wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
operating_system=`echo $(lsb_release -rs)`
if [[ $operating_system == '20.04' ]];
then
	echo $operating_system
	sleep 5
	wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
elif [[ $operating_system == '18.04' ]];
then
	echo $operating_system
	sleep 5
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
fi
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt update
sudo apt upgrade -y
# Install PowerShell
sudo apt install -y powershell
echo "Cleaning up..."
rm -f packages-microsoft-prod.deb*
#PowerShell Version
pwsh --version
echo ""
echo "PowerShell Installation Complete..."
echo ""
echo "Script [[ $0 ]] Updated Existing Packages and Installed AWS-CLI V2, VS Code and PowerShell..."
