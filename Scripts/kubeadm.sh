#!/bin/bash

# Add the Kubernetes repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the package list
sudo apt-get update

# Install Kubernetes, kubeadm, kubelet, and kubectl
sudo apt-get install -y kubelet kubeadm kubectl

# Hold the packages to prevent updates
sudo apt-mark hold kubelet kubeadm kubectl
