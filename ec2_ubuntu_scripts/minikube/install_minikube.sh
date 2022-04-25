#!/bin/bash
echo "Minikube..."
echo "Documentation: https://minikube.sigs.k8s.io/docs/start/"
echo "Latest Version: https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
echo ""
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
echo "Minikube Installed"
echo ""
which minikube
echo ""
echo "MiniKube Version..."
minikube version

