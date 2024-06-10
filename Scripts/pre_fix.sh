#!/bin/bash

# Enter your desired IP address and hostname
read -p "Enter the desired IP address: " desired_ip
read -p "Enter the desired hostname: " desired_hostname

# Set the hostname
echo "Setting hostname to $desired_hostname..."
hostnamectl set-hostname $desired_hostname

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Upgrade the packages
echo "Upgrading packages..."
sudo apt-get upgrade -y

# Print out a message
echo "Update and upgrade complete!"

# Turn off swap - required for Kubernetes
echo "Turning off swap..."
sudo swapoff -a

# Edit fstab to prevent swap from turning on after reboot
echo "Disabling swap on boot in /etc/fstab..."
sudo sed -i '/swap/s/^/#/' /etc/fstab

# Load br_netfilter module
echo "Loading br_netfilter module..."
sudo modprobe br_netfilter

# Ensure br_netfilter module is loaded on boot
echo "br_netfilter" | sudo tee -a /etc/modules-load.d/k8s.conf

# Load overlay module
echo "Loading overlay module..."
sudo modprobe overlay

# Ensure overlay module is loaded on boot 
echo "overlay" | sudo tee -a /etc/modules-load.d/k8s.conf

# Set the necessary kernel parameters
echo "Setting kernel parameters..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Apply sysctl changes and persist across reboots
echo "Applying sysctl changes..."
sudo sysctl --system

# Set static IP address (this will vary depending on your network interface)
echo "Setting static IP address..."
cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
      dhcp4: no
      addresses:
        - $desired_ip/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
EOF

# Change permisiion of 01-netcfg.yaml
sudo chmod 600 /etc/netplan/01-netcfg.yaml

# Apply netplan changes
echo "Applying netplan changes..."
sudo netplan apply

# Enable UFW
sudo ufw enable

# Allow traffic on port 8080
sudo ufw allow 8080/tcp

# Reload UFW rules
sudo ufw reload

echo "VM is ready for Kubernetes installation."
