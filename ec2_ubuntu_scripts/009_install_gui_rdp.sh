#!/bin/bash
#Install GUI lxde, xrdp
sudo apt install -y lxde xrdp
sleep 10
echo "Setting password for USER: ${USER}"
echo "ubuntu" | sudo passwd --stdin ${USER}
