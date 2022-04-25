#!/bin/bash
minikube start --interactive=true --output='text' --cpus='2' \
                                --nodes='3' \
                                --container-runtime='docker' --cni='calico' \
                                --cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
                                --wait-timeout=6m0s --delete-on-failure=false \
                                --kubernetes-version=v1.23.4 --auto-update-drivers=false \
                                --log_file=/home/ubuntu/minikube-start.log \
				--addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns
sleep 5
minikube status
echo ""
echo "Storage and Memory"
fdisk -h
echo ""
free
echo "All ok..."
