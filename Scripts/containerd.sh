#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install containerd
echo "Installing containerd..."
sudo apt install -y containerd

# Check the status of containerd
echo "Checking the status of containerd..."
systemctl status containerd

# Generate default containerd configuration file
echo "Generating default containerd config..."
containerd config default | sudo tee /etc/containerd/config.toml

# Create the containerd directory if it doesn't exist
if [ ! -d "/etc/containerd" ]; then
    echo "Creating /etc/containerd directory..."
    sudo mkdir /etc/containerd
fi

# Edit the containerd configuration file
echo "Please edit the containerd configuration file as needed."
sudo nano /etc/containerd/config.toml

# Reload the systemd daemon
echo "Reloading the systemd daemon..."
systemctl daemon-reload


# Restart Containerd 
systemctl restart containerd

echo "Script execution completed."
