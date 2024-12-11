#!/bin/bash
# Setup for Control Plane (Master) servers in AWS with Cilico CNI

set -euxo pipefail

# Configuration variables
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

# Fetch the instance's private IP from AWS metadata service
MASTER_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Pull required images for Kubernetes components
sudo kubeadm config images pull

# Initialize kubeadm
sudo kubeadm init --control-plane-endpoint="$MASTER_PRIVATE_IP" --apiserver-cert-extra-sans="$MASTER_PRIVATE_IP" --pod-network-cidr="$POD_CIDR" --node-name "$NODENAME"

# Configure kubeconfig for the current user
mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# Install Claico Network Plugin Network 

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Enable kubelet service to start automatically on boot
sudo systemctl enable kubelet
echo ""
echo "Kubernetes control plane setup completed successfully with Cilico"
echo ""
# Generate join command for worker nodes
JOIN_COMMAND=$(kubeadm token create --print-join-command)

# Display the join command with clear formatting
echo ""
echo "------------------------------------------------"
echo "Worker node join command:"
echo ""
echo "$JOIN_COMMAND"
echo "------------------------------------------------"
echo ""
