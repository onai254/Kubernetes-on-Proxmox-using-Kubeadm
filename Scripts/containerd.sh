#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install containerd
echo "Installing containerd..."
sudo apt install -y containerd

# Check if containerd is running
echo "Checking if containerd is running..."
if systemctl is-active --quiet containerd; then
  echo "Containerd is running."
else
  echo "Containerd is not running."
fi

# Create the containerd directory
sudo mkdir -p /etc/containerd

# Generate default containerd configuration file
echo "Generating default containerd config..."
containerd config default | sudo tee /etc/containerd/config.toml

# Edit the containerd configuration file
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml


# Reload the systemd daemon
echo "Reloading the systemd daemon..."
systemctl daemon-reload


# Restart Containerd 
systemctl restart containerd

echo "Script execution completed."
