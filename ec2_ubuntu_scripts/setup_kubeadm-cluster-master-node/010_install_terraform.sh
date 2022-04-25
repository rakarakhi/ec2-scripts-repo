#!/bin/bash
#Install Terraform on Ubuntu from HashiCorp
#
echo "Installing Terraform CLI..."
echo ""
echo "Update Existing Package..."
sudo apt update
sudo apt upgrade -y
sleep 5
echo "Updating Local Repository for Terraform..."
echo ""

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
#
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
#apt-add-repository automatically runs apt update
#
sudo apt install -y terraform
#
echo "Terraform Successfully Installed..."
echo ""
terraform -version
echo ""
terraform -help
