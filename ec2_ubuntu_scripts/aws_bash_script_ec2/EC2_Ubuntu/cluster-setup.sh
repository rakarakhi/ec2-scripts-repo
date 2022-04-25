#!/bin/bash
#Setup Hostname
nodename=ControlPlane01
hostnamectl set-hostname $nodename
#Get IP Address
internalIP=`curl http://169.254.169.254//latest/meta-data/local-ipv4`
#Add entry into etc/hosts file
echo "$internalIP         $nodename" >> /etc/hosts
#
#Turn wap off
swapoff
#
#Drivers for sypporting systemd instead of cgroupfs
#
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
#
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
#
sysctl --system
#
# containerd
############
### This section contains the necessary steps to use containerd as CRI runtime.
### Use the following commands to install Containerd on your system:
### Install and configure prerequisites:
#
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
#
sudo modprobe overlay
sudo modprobe br_netfilter
#
# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
#
# Apply sysctl params without reboot
sudo sysctl --system


# Update the packages and upgrade
sudo apt update -y
sudo apt upgrade -y
#
# Set up the repository
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt update -y
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    wget \
    tree \
    nano \
    vim
#
## Add Docker’s official GPG key:
#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
# Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:
#
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
#
# Add a non-priviledged user in docker group
#
sudo usermod -aG docker ubuntu
#
# Handle docker and containerd service to ensure systemd is used
# Configure docker and containerd services to use "systemd"

## Configure containerd:

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml

# Restart containerd process:

sudo systemctl restart containerd
sudo systemctl status containerd

read -p "Press [Enter] key to start next steps..."

#Using the systemd cgroup driver:
#To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set
#	[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
#  	...
#  	 [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
#    	  SystemdCgroup = true
#
#	systemctl restart containerd
echo ""
echo "To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set"
echo "	[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]"
echo "  	..."
echo "  	 [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]"
echo "    	  SystemdCgroup = true"
echo ""
echo "Make these updates in another session...."
echo ""
read -p "Press [Enter] key to continue..."
sudo systemctl restart containerd
#
## Configure Docker Service:
## And going forward docker service should use systemd by default.
## Check:

sudo docker info | grep -i Cgroup
echo ""
read -p "Press [Enter] key to next step..."
#Step 1: Stop docker service
#systemctl stop docker
sudo systemctl stop docker
sudo systemctl stop docker.sock
echo ""
echo "Step 2: change on files /etc/systemd/system/multi-user.target.wants/docker.service"
echo ""
echo "Make these updates in another session...."
echo ""
read -p "Press [Enter] key to next step..."
# Step 2: change on files /etc/systemd/system/multi-user.target.wants/docker.service and /lib/systemd/system/docker.service
## Note: the file /lib/systemd/system/docker.service is sym-link.
##
###From :
#	ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
###To :
#    ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl status docker
read -p "Press [Enter] key to next step..."
sudo docker info | grep -i Cgroup
echo ""
read -p "Press [Enter] key to next step..."

# Install Minikube Latest:
# https://github.com/kubernetes/minikube

# Download the latest:
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube

# To use Minikube
# minikube start --output='text' --nodes='2' --cpus='2' --container-runtime='docker' --cni='flannel' --kubernetes-version='v1.20.0'  --auto-update-drivers=false --cache-images=true  --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd --wait-timeout=6m0s --delete-on-failure=false --log_file='./minikube_start.log' --addons=dashboard --addons=metrics-server --addons="ingress" --addons="ingress-dns" 

# To use kubernetes
# Install kubeadm, kubectl and kubelet on all nodes

sudo apt update && \
sudo apt install -y apt-transport-https ca-certificates curl && \
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list 

sudo apt update && \
sudo apt install -y kubelet=1.20.1-00 kubeadm=1.20.1-00 kubectl=1.20.1-00 && \
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize cluster....
kubeadm init --apiserver-cert-extra-sans=controlplane \
    --apiserver-advertise-address $internalIP --pod-network-cidr=10.244.0.0/16

# Install CNI
# https://github.com/flannel-io/flannel#deploying-flannel-manually
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
# Install WeeveNet
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"