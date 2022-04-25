#!/bin/bash
# minikube start --interactive=true --output='text' --cpus='2' \
#                                --nodes='3' \
#                                --container-runtime='docker' --cni='calico' \
#                                --cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
#                                --wait-timeout=6m0s --delete-on-failure=false \
#                                --kubernetes-version=v1.23.4 --auto-update-drivers=false \
#                                --log_file=/home/ubuntu/minikube-start.log \
#				--addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns
#
echo "Checking Minikube Status..."
echo ""
echo "Minikube Version:"
minikube version
sleep 2
echo ""
echo "Minikube Status of Cluster: \"minikube\""
minikube status
echo ""
echo "Storage and Memory"
fdisk -l
echo""
lsblk
echo ""
echo "Memory..."
free
echo "Host and User Details"
echo "Host details..."
hostnamectl
echo ""
echo "User: ${USER}"
echo "IP Address..."
ip -br -4 -h -a -f inet address
echo "All ok..."
