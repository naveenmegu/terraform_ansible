#!/bin/bash

# Step 1 - Kubernetes Deployment
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Step 2 - Update Ubuntu
sudo apt update

# Step 3 - Install Docker
sudo apt install docker.io -y
sudo usermod -aG docker $USER
newgrp docker

# Step 4 - Start and Enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Step 5 - Install Kubernetes
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# Step 6 - Kubernetes Installation Tools
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Step 7 - Assign Unique Hostname for Each Server Node
sudo hostnamectl set-hostname master-node

# Step 8 - Initialize Kubernetes on Master Node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Note down the kubeadm join command for worker nodes

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Step 9 - Deploy Pod Network to Cluster
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Verify
kubectl get pods --all-namespaces
