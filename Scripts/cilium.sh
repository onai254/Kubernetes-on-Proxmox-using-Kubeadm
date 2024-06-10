#!/bin/bash

# Download cilium-cli (adjust URL based on version)
curl -L --remote-name https://github.com/cilium/cilium/releases/download/v1.15.5/cilium-linux-amd64.tar.gz

# Extract the archive
tar xvf cilium-linux-amd64.tar.gz

# Move cilium-cli to a directory in your PATH (e.g., /usr/local/bin)
mv cilium-linux-amd64/cilium /usr/local/bin/cilium

# Install Cilium using cilium-cli (adjust options as needed)
cilium install

# Start Cilium agent
cilium agent