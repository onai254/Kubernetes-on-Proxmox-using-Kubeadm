#!/bin/bash

# Install Cilium binaries on the master node
curl -sL https://github.com/cilium/cilium/releases/download/v1.12.2/cilium-linux-amd64.tar.gz | tar xz
sudo mv cilium /usr/local/bin/

# Deploy Cilium operator
kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.12.2/install/kubernetes/quick-install.yaml

# Wait for Cilium operator to be running
while [[ $(kubectl get pods -n kube-system | grep cilium-operator | grep Running | wc -l) -lt 1 ]]; do
  echo "Waiting for Cilium operator to be running..."
  sleep 5
done

# Deploy Cilium networking components
cilium install

# Wait for Cilium networking components to be running
while [[ $(kubectl get pods -n kube-system | grep cilium-agent | grep Running | wc -l) -lt 1 ]]; do
  echo "Waiting for Cilium networking components to be running..."
  sleep 5
done

# Check if nodes are in a ready state
while [[ $(kubectl get nodes | grep NotReady | wc -l) -gt 0 ]]; do
  echo "Waiting for nodes to be ready..."
  sleep 5
done

echo "Nodes are ready!"
