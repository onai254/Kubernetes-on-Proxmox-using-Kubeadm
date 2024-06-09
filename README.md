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
You can clone this repository and run the scripts to 
```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl
