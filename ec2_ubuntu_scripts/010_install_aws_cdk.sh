#!/bin/bash
#Script to Install AWS-CDK
#https://docs.aws.amazon.com/cdk/v2/guide/cli.html
#Node.js must be present...
sudo apt update
sudo apt upgrade -y
#sudo apt install -y nodejs npm
#
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
sudo apt install npm
sudo npm install -g aws-cdk             # install latest version
#npm install -g aws-cdk@X.YY.Z      # install specific version
#
##npm WARN notsup Unsupported engine for aws-cdk@2.20.0: wanted: {"node":">= 14.15.0"} (current: {"node":"10.19.0","npm":"6.14.4"})
##npm WARN notsup Not compatible with your version of node/npm: aws-cdk@2.20.0
##npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.3.2 (node_modules/aws-cdk/node_modules/fsevents):
##npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.3.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})
#
echo "AWS-CDK Version..."
cdk --version
sleep 5
#
#Working with AWS-CDK with Python...
#
########################################
# INSTALL PYTHON FIRST
########################################
python3 -m ensurepip --upgrade
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade virtualenv
