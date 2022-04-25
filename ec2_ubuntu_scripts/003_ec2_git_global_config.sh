#!/bin/bash
#Git Global Configuration Setup
sudo apt install -y git
git config --global core.autocrlf true
git config --global http.sslVersion tslv1.2
#git config --global http.sslVerify true
git config --global http.sslVerify false
git config --global user.name "Rahuldeb Chakrabarty"
git config --global user.email "Rahuldeb.Chakrabarty@hotmail.com"

