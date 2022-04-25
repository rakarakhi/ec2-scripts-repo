#!/bin/bash
echo "Stopping cluser minkube..."
echo ""
minikube stop -p minikube
sleep 5
minikube starus
echo ""
echo "Storage and Memory"
echo "All ok..."
