#!/bin/bash
#
#Install Docker
#
#checking of root user...
#
if [[ ${USER} != 'root' ]];
then
        echo "User ${USER} is not recommended to be execute this script..."
        echo "use \"sudo -i\" to login as root and then excute $0 script..."
        exit -1
fi
#
echo ""
whoami
sleep 5
#
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    wget
#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl restart docker
sudo systemctl status docker
read -p "Press any key to continue.."
sudo systemctl restart containerd
sudo systemctl status containerd
read -p "Press any key to continue.."
echo "if Required Reboot the host ${HOSTNAME}..."
echo "Add a non-privileged user in 'docker' group..."
echo "All done...
