#!/bin/bash
# Upgrade Existing Packages...
echo "Prerequisites for KubeAdm Cluster master | controlplane Node Setup..."
echo "Can run as root user or logged in $USER"
echo ""
sudo apt update
sudo apt upgrade -y

#containerd
#This section contains the necessary steps to use containerd as CRI runtime.
#Use the following commands to install Containerd on your system:
#Install and configure prerequisites:

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

echo "Changes done and will persist reboot..."
