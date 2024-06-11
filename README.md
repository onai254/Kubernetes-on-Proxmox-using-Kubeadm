# Kubernetes on Proxmox using Kubeadm

## Introduction
This repository contains resources and instructions for bootstrapping a Kubernetes (K8s) cluster on a Proxmox virtual machine (VM) running Ubuntu. It is designed for those who wish to leverage Proxmox's virtualization capabilities to create a robust and scalable Kubernetes environment.

## Prerequisites
- A Proxmox VE server
- An Ubuntu VM set up on Proxmox
- Sufficient resources allocated to the VM (CPU, Memory, and Storage)

## Installation

### Step 1: Prepare the  VM
Ensure your VM is updated and has all the necessary dependencies:
You can clone this repository and run the scripts 

```bash
git clone https://github.com/onai254/Kubernetes-on-Proxmox-using-Kubeadm.git
```

The `pre_fix.sh` script automates the preparation of an Ubuntu VM for Kubernetes installation. It performs system updates, sets a static IP address, configures the hostname, and applies necessary system configurations.

Initializing control plane node
After all VMs are provisioned, follow this guide to setup our cluster:

$ vagrant ssh master
$ sudo kubeadm init --apiserver-advertise-address=192.168.56.10 --pod-network-cidr=10.244.0.0/16
Note the token gotten after the above command

$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
Let's configure Calico for networking:

$ kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
$ kubectl create -f ./shared/scripts/helpers/custom-resources.yaml
Joining worker nodes
$ vagrant ssh node-01
$ sudo kubeadm join 192.168.56.10:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
The join command can be found after running the kubeadm init command above but we can find token and hash values by running the following commands on the control plane node:

$ kubeadm token list
$ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
   openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
If for some reason you cant find the token, you can regenerate with

$ kubeadm token create --ttl 8760h
Do the same procedure on each worker node.

Now we should have a 3-node Kubernetes cluster running on our local machine. here are 
