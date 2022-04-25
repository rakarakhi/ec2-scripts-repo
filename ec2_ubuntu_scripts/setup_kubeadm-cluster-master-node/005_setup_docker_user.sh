#!/bin/bash
#
#Adding default non-root docker user
#
if [[ ${USER} == 'root' ]];
then
	echo "User ${USER} is not recommended to be used as Docker User..."
	echo "Login as ubuntu, ec2-user or other local non-root user and add them to docker group..."
	exit -1
else
	sudo usermod -aG docker ${USER}
#https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket
	sudo chmod 666 /var/run/docker.sock
fi
#
echo "Check Docker Verion..."
echo ""
docker version
echo ""
sleep 5
read -p "Press Enter Key to continue..."
#
echo "Check Docker Info..."
echo ""
docker info
echo ""
sleep 5
read -p "Press Enter Key to continue..."
#
sleep 2
#
echo "Check Docker Installation..."
echo "Who am I?"
whoami
echo ""
echo ""
echo "Launching a Container using hellow-world:latest image in Docker Hub..."
echo ""
docker run hello-world
echo ""
echo ""
echo "Docker CE is set in $HOSTNAME..."
