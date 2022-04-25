#!/bin/bash
#Kubernets Installation and Addons
echo "Refreshing repository list and updating existing packages..."
sudo apt update && sudo apt upgrade -y
echo ""
echo "Update complete..."
sleep 5
echo "Installing Kubernetes Components"
sleep 5
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
echo ""
echo "Updating package lists..."
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
#Install specific version of Kubernet components
#sudo apt-get install -y kubelet=1.22.0-00 kubeadm=1.22.0-00 kubectl=1.22.0-00
sudo apt-mark hold kubelet kubeadm kubectl
#
echo "kubeadm version..."
kubeadm version
echo "kubelet version..."
kubelet --version
echo "kubectl version..."
kubectl version
sleep 5
#Installation of .krew
echo ""
echo "Setting Up .krew - kubectl addons..."
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
#
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
cp ~/.bashrc ~/.bashrc_org
echo "PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"" >> ~/.bashrc
clear
cat ~/.bashrc
sleep 20
kubectl krew install whoami tree trace ctx ns get-all who-can tail topology skew service-tree rbac-tool rbac-view np-viewer ktop graph images access-matrix doctor example explore
#
kubectl krew list
