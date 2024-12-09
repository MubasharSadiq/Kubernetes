#!/bin/bash
#
# Setup for Control Plane (Master) servers in AWS

set -euxo pipefail

# Configuration variables
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"
KUBERNETES_VERSION="1.30.0-00"  # Specify the desired Kubernetes version

# Fetch the instance's public IP from AWS metadata service
MASTER_PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Install specific version of kubeadm, kubelet, and kubectl
sudo apt-get update
sudo apt-get install -y kubelet="$KUBERNETES_VERSION" kubeadm="$KUBERNETES_VERSION" kubectl="$KUBERNETES_VERSION"
sudo apt-mark hold kubelet kubeadm kubectl

# Pull required images
sudo kubeadm config images pull

# Initialize kubeadm
sudo kubeadm init --control-plane-endpoint="$MASTER_PUBLIC_IP" --apiserver-cert-extra-sans="$MASTER_PUBLIC_IP" --pod-network-cidr="$POD_CIDR" --node-name "$NODENAME"

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
echo "Worker node join command:"
echo "$JOIN_COMMAND"
