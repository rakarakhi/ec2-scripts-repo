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
Help()
{
	# Display Help
   	echo "Creates Minikube Cluster"
   	echo ""
	echo "Syntax: $0 [-n|c|h]"
   	echo "options:"
   	echo "c      Number of Minikube Clusters"
   	echo "n	Number of Nodes in each Cluste"
   	echo "h      Print this Help."
   	echo
}
############################################################
# System Status =beginning                                                     #
############################################################
System_Status_Start()
{
	echo "Starting Minikube Single Node Cluster on host $HOSTNAME"
	echo " "
	hostnamectl
	echo "Logged in User"
	echo $USER
	echo "Storage Usage"
	df -h
	echo "Memory and Swap"
	free
	echo "Minikube Version"
	minikube version
	echo ""
	echo "Kubernetes Version"
 	kubectl version -o 'yaml' --short=true
}
############################################################
# System Status = After Cluster(s) are set                                                    #
############################################################
System_Status_End()
{
	sleep 2
	echo "Storage Utilization"
	df -h
	echo ""
	sudo fdisk -l
	echo ""
	lsblk
	echo ""
	echo "Memery Utilization"
	free
	echo ""
        kubectl version -o 'yaml' --short=true
	echo "Minikube Status..."
	minikube status
	echo ""
}
############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
#
Process_Input()
{
	#if [ "$#" -eq 0 ]
	#then
	#	echo "No Valid Argumets are passed..."
	#	echo "Please check the Help..."
	#	echo ""
	#	Help
	#	read -p "Press any key to resume ..."
	#	exit 0
	#fi
	#
	while getopts ":h:c:n:"  option
	do
		case "${option}" in
			h) ##Display help and exit
                       		Help
                       		exit;;
		        c) # handle number of CLusers
				totalclusters=${OPTARG};;	
			n) # Handle Number of Nodes in each cluster
				totalnodes=${OPTARG};;
	      		*) # Invalid option
         			echo "Error: Invalid option"
		        	echo "Use $0 -h"
         			exit;;
		esac
	done
# Manually See the arguments
	echo "Running Scprt is: $0"
	totalclusters=2
	totalnodes=1
	echo "Number of Cluser(s) to be Provisioned is: $totalclusters"
	echo "Number of Node(s) in each Cluser to be Provisioned is: $totalnodes"
	read -p "Press any key to resume ..."
#
# Handle Toltal Number of Node and Cluser to Handle Hardware Capacity
#
# Arguments:
#totalnodes=${1:-1} #if not specified 1 node minikube cluster
#container_cni=${2:-1} # set up using runtime docker
#totalclusters=1
#
	if [[ $totalnodes -le 0 ]]
	then
		echo "Total Nodes must be 1 or 2"
		echo "Setting Number of Nodes to 1"
		echo "Then as per Hardware Capacity, setting Cluser to 1"
		totalnodes=2
		totalclusters=1
		echo "Will Start $totalclusters MiniKube Cluster each with $totalnodes Nodes"
	elif [ $totalnodes -eq 2 ]
	then
		echo "Cannot provision more than 2 nodes..."
		echo "Setting to 2 Nodes..."
		totalnodes=1
		totalclusters=2
		echo "Number of Nodes set to: $totalnodes in Cluster in each of $totalclusters ..."
	elif [ $totalnodes -eq 1 ]
        then
                echo "Provisioning 1 nodes..."
                echo "Setting to 2 Clusters..."
                totalnodes=1
                totalclusters=2
                echo "Number of Nodes set to: $totalnodes in Cluster in each of $totalclusters Clusters..."
	else
		echo "Cannot accommodate the configuration to given VM"
		echo "Please provide valid values. Good bye!!!"
		exit 0
	fi
	echo ""
	echo "Total Clusters: $totalclusters"
	echo "Total Nodes in each Cluster $totalnodes"
	read -p "Press any key to resume ..."
}
#
#
#############################################################
# Container Runtime and Container Network Interface Selection
#############################################################
# Get the options
#
CRI_n_CNI_Selector()
{
	echo ""
	echo "Menu to Select available CRI and CNI..."
	echo "Option 1: CRI: docker 	CNI: calico" 
	echo "Option 2: CRI: cri-o 	CNI: calico"
	echo "Option 3: CRI: containerd CNI: calico"
	echo "Option 4: CRI: docker 	CNI: flannel"
	echo "Option 5: CRI: cri-o 	CNI: flannel"
	echo "Option 6: CRI: containerd CNI: flallel"
	echo "Valid Option: a Number btween 1 - 6..."
	echo ""
	echo "Enter the option: "
	read cri_cni_option

	case  ${cri_cni_option} in
		1)
			container_runtime='docker'
			pod_cni='calico';;
		2)
			container_runtime='cri-o'
                	pod_cni='calico';;
	        3)
        	        container_runtime='containerd'
                	pod_cni='calico';;
	        4)
        	        container_runtime='docker'
                	pod_cni='flannel';;
	        5)
        	        container_runtime='cri-o'
                	pod_cni='flannel';;
       		6)
                	container_runtime='containerd'
                	pod_cni='fnallel';;
		*)	echo "Invalid combination...."
			echo "Using Option - 1, as default"
                	container_runtime='docker'
                	pod_cni='calico';;
	esac
}
#
#
############################################################
# Cluster Creation Program... 
############################################################
# Get the options
#
# Setting some defaults
	container_runtime=''
	pod_cni=''
#
Cluster_Creator()
{
        echo "Starting ${totalclusters} Minikube Cluster, each with ${totalnodes} Nodes and -container-runtime=${container_runtime} --cni=${pod_cni}"
	read -p "Press any key to resume ..."
 	for i in $(seq ${totalclusters})
		do
                        minikube start -p minikube-cluster-${i} \
				--interactive=true --output='text' --cpus='2' \
                                --nodes=$totalnodes \
                                #--container-runtime='docker' --cni='calico' \
                                --container-runtime=${container_runtime} --cni=${pod_cni} \
                                --cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
                                --wait-timeout=6m0s --delete-on-failure=false \
                                --kubernetes-version=v1.23.4 --auto-update-drivers=false \
                                --log_file=/home/ubuntu/minikube-start.log \
                                --addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns
			echo ""
			read -p "Press any key to resume ..."
			minikube status -p minikube_cluster_${i}
		done
}
#
#
############################################################
# Main Funtion
############################################################
# Get the options
#
# remove existing configuration 
# Need to midify based on cluster name
# rm -rf .minikube/
# Various option
## Existing setup
# minikube start --output='text' --cpus='2' --container-runtime='docker' --cni='calico' --cache-images=true --driver='docker' --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd --wait-timeout=6m0s --delete-on-failure=false   --kubernetes-version=v1.23.4 --auto-update-drivers=false --log_file=/home/ubuntu/minikube-start.log --addons=dashboard --addons=metrics-server --addons="ingress" --addons="ingress-dns"
### Now onwards --driver will be omitted 
##case $container_cni in
##        1)
##                        echo "Starting Minikube Cluster with $totalnodes Nodes and -container-runtime='docker' --cni='calico'"
##                        minikube start --interactive=true --output='text' --cpus='2' \
##                                --nodes=$totalnodes \
##                                --container-runtime='docker' --cni='calico' \
##                                --cache-images=false --force-systemd=true --extra-config=kubelet.cgroup-driver=systemd \
##                                --wait-timeout=6m0s --delete-on-failure=false \
##                                --kubernetes-version=v1.23.4 --auto-update-drivers=false \
##                                --log_file=/home/ubuntu/minikube-start.log \
##                                --addons=dashboard --addons=metrics-server --addons=ingress --addons=ingress-dns ;;
##        2)
##
### --interactive to be added
#
main()
{
	#Process Arguments...
	if [ "@0" = "0" ]
	then
		Help
	fi
	Process_Input
	#System Precheck...
	System_Status_Start
	#Remove old Minikube configuration
	# remove existing configuration
	# Need to midify based on cluster name
	rm -rf .minikube/
	#
	# CRI and CNI Selector...
	#
	CRI_n_CNI_Selector
	#Create Minmikube Clluster with varuous container-runtime and cmi combination...
	case ${cri_cni_option} in
        	1)
			echo $container_runtime
			echo $pod_cni
			Cluster_Creator ;;
        	2)
                	echo $container_runtime
                	echo $pod_cni
	                Cluster_Creator ;;
        	3)
                	echo $container_runtime
	                echo $pod_cni
        	        Cluster_Creator ;;
        	4)
                	echo $container_runtime
	                echo $pod_cni
                	Cluster_Creator ;;
        	5)
                	echo $container_runtime
                	echo $pod_cni
                	Cluster_Creator ;;
	        6)
        	        echo $container_runtime
                	echo $pod_cni
                	Cluster_Creator ;;
		*)
			echo "Unsupported combination..."
			echo "Using Option - 1 settings..."
                	container_runtime='docker'
                	pod_cni='calico'
                	echo $container_runtime
                	echo $pod_cni
                        Cluster_Creator ;;
	esac	
 	#
	#Check installation status
	System_Status_End
	#
}
#
	main "$@"
#
