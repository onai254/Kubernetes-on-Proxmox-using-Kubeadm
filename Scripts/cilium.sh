#!/bin/bash

# Install Cilium binaries on the master node
wget https://github.com/cilium/cilium/releases/download/v1.13.0/cilium-linux-amd64.tar.gz
tar xvf cilium-linux-amd64.tar.gz

sudo mv cilium /usr/local/bin/

# Deploy Cilium operator (update URL if necessary)
kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.13.0/install/kubernetes/quick-install.yaml

# Wait for Cilium operator to be running
while [[ $(kubectl get pods -n kube-system | grep cilium-operator | grep Running | wc -l) -lt 1 ]]; do
  echo "Waiting for Cilium operator to be running..."
  sleep 5
done

# Deploy Cilium networking components
cilium install

# Wait for Cilinux networking components to be running
while [[ $(kubectl get pods -n kube-system | grep cilियम-agent | grep Running | wc -l) -lt 1 ]]; do
  echo "Waiting for Ciliu networking components to be running..."
  sleep 5
done

# Check if nodes are in a ready state
while [[ $(kubectl get nodes | grep NotReady | wc -l) -gt 0 ]]; do
  echo "Waiting for nodes to be ready..."
  sleep 5
done

echo "Nodes are ready!"
