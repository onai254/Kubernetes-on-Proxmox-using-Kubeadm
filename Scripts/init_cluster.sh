#!/bin/bash

# Get the IP address of the master node
MASTER_IP=$(ip addr show ens18 | awk '$1 == "inet" {print $2}' | cut -d/ -f1)

# Initialize the Kubernetes cluster using kubeadm
sudo kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address $MASTER_IP

# Get the join command for future nodes to join the cluster
join_cmd=$(kubeadm token create --print-join-command)

# Print the join command
echo "Join command for future nodes: $join_cmd"

# Create /.kube directory
mkdir -p $HOME/.kube

# Change the location of Kubeconfig file
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Change ownership of $HOME/.kube/config to current user
sudo chown $(id -u):$(id -g) $HOME/.kube/config
