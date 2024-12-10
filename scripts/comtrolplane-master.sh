#!/bin/bash
#
# Setup for Control Plane (Master) servers in AWS

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

# Install Calico Network Plugin
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml

# Enable kubelet service
sudo systemctl enable kubelet

echo "Kubernetes control plane setup completed successfully"

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
