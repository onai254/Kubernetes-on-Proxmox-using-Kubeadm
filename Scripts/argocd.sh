# Download the latest stable version of Argo CD CLI
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64

# Install the Argo CD CLI binary
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

# Remove the downloaded binary
rm argocd-linux-amd64

# Verify the installation
argocd version

# Create the argocd namespace
kubectl create namespace argocd

# Set the current context's namespace to argocd
kubectl config set-context --current --namespace=argocd

# Apply the Argo CD installation manifests
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
