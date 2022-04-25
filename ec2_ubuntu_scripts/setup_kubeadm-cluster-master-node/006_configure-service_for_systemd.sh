#!/bin/bash
#/etc/containerd/config.toml
#
#
# Configure containerd:

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo cp /etc/containerd/config.toml /etc/containerd/config.toml.org
#Restart containerd:
#
#sudo systemctl restart containerd
sudo systemctl restart containerd.service
#
#Using the systemd cgroup driver
#To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set
#
#[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
#  ...
#  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
#    SystemdCgroup = true
# Serach grep [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options] and add new line SystemdCgroup = true
#sudo sed -i 's/[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]/&\nSystemdCgroup = true/' /etc/containerd/config.toml
target_line="         [plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime.options]"
line_to_add="           SystemdCgroup = true"
sudo rm -rf /etc/containerd/config.toml
sudo touch /etc/containerd/config.toml
#
while IFS= read -r line || [[ -n "$line" ]]; do
    	echo "Text read from file: $line"
    	sudo echo "$line" >>/etc/containerd/config.toml
	if [[ $line == $target_line ]];
	then
		sudo echo "$line_to_add" >>/etc/containerd/config.toml
	fi
done < "/etc/containerd/config.toml.org"
#
#
sudo systemctl restart containerd
sleep 120
#
#Configure Docker Service
## configure Docker Service:

#And going forward docker service should use systemd by default.
#Check:
#
sudo docker info | grep -i Cgroup
#
#Step 1: Stop docker service
#
sudo systemctl stop docker.service
sudo systemctl stop docker.socket
#
#Step 2: change on files /etc/systemd/system/multi-user.target.wants/docker.service and /lib/systemd/system/docker.service
#Note: the file /lib/systemd/system/docker.service is sym-link.
#
#From :
#	ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
#To:
#    	ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd
sudo sed -i 's/ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock/ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd/' /etc/systemd/system/multi-user.target.wants/docker.service
#
sudo systemctl daemon-reload
sudo systemctl start docker.service
sudo systemctl start docker.socket
sudo systemctl status docker.service
#
docker info
