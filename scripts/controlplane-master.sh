#!/bin/bash
#
# Setup for Control Plane (Master) servers in AWS with Cilium CNI

set -euxo pipefail

# Configuration variables
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

# Fetch the instance's public IP from AWS metadata service
MASTER_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Pull required images
sudo kubeadm config images pull

# Initialize kubeadm
sudo kubeadm init --control-plane-endpoint="$MASTER_PRIVATE_IP" --apiserver-cert-extra-sans="$MASTER_PRIVATE_IP" --pod-network-cidr="$POD_CIDR" --node-name "$NODENAME"

# Configure kubeconfig
mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# Install Cilium Network Plugin
kubectl create -f https://github.com/cilium/cilium/releases/download/v1.13.3/cilium-operator.yaml
kubectl create -f https://github.com/cilium/cilium/releases/download/v1.13.3/cilium.yaml

# Install Cilium Hubble (Optional, for monitoring and visibility)
kubectl create -f https://github.com/cilium/hubble/releases/download/v0.11.0/hubble-ui.yaml

# Enable kubelet service
sudo systemctl enable kubelet

echo "Kubernetes control plane setup completed successfully with Cilium"

# Generate join command for worker nodes
JOIN_COMMAND=$(kubeadm token create --print-join-command)

# Display with clear formatting and spaces
echo ""
echo "------------------------------------------------"
echo "Worker node join command:"
echo ""
echo "$JOIN_COMMAND"
echo "------------------------------------------------"
echo ""