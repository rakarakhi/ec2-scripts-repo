# This script is an experiment to run minkube with:
# - different container runtime: docker|containerd|cri-o
# - File system to be picked up based on installed modules. Need to see...
# - Pod Networking: --cni auto, bridge, calico, cilium, flannel, kindnet, or path to a CNI manifest (default: auto)
# - --driver: Driver is one of: virtualbox, vmwarefusion, kvm2, vmware, none, docker, podman, ssh (defaults to auto-detect)

# - **Need not to worry about cgroupfs as stand is now systemd
#
#   Core challenge is to enable logic to deal this various permutations and combinations
#!/bin/bash

# Help function...
############################################################
# Help                                                     #
############################################################
echo ""
echo "Creating Cluser: minikube-cluster-1"
echo ""
sleep 2
minikube start -p minikube-cluster-1 \
	--interactive=true --output='text' --cpus='2' \
        --nodes='3' \
	--container-runtime='crio' --cni='calico' \
	--cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
	--wait-timeout=6m0s --delete-on-failure=false \
	--kubernetes-version=v1.23.4 --auto-update-drivers=false \
	--log_file=/home/ubuntu/minikube-start2.log \
	--addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns
echo ""
sleep 5
minikube status -p minikube-cluster-1 
echo ""
echo ""
echo "Creating Cluser: minikube-cluster-2"
echo ""
sleep 2
minikube start -p minikube-cluster-2 \
        --interactive=true --output='text' --cpus='2' \
        --nodes='3' \
        --container-runtime='docker' --cni='flannel' \
        --cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
        --wait-timeout=6m0s --delete-on-failure=false \
        --kubernetes-version=v1.23.4 --auto-update-drivers=false \
        --log_file=/home/ubuntu/minikube-start1.log \
        --addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns
echo ""
sleep 5
minikube status -p minikube-cluster-2
echo ""
echo "Memory"
free -h
echo ""
echo "Storage"
df -h
echo ""
sudo fdisk -l
echo ""
lsblk
echo ""
echo "Minikube Cluster Started..."
 
 
