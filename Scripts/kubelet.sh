#!/bin/bash
sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# Install Kubernetes, kubeadm, kubelet, and kubectl
sudo apt-get install -y kubelet kubeadm kubectl

# Hold the packages to prevent updates
sudo apt-mark hold kubelet kubeadm kubectl

# Start kubelet
sudo systemctl start kubelet

sudo systemctl enable --now kubelet
