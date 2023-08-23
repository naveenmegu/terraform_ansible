#!/bin/bash

# Update and install necessary packages
sudo apt-get update -y
sudo apt-get install -y unzip
sudo apt-get install -y openjdk-11-jdk

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install eksctl
curl -LO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar xzvf eksctl_$(uname -s)_amd64.tar.gz
sudo mv eksctl /usr/local/bin

# Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# chmod +x kubectl
# sudo mv kubectl /usr/local/bin

# Install the latest version of Terraform
TERRAFORM_LATEST_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep "tag_name" | cut -d'"' -f4 | cut -d'v' -f2)
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_LATEST_VERSION}/terraform_${TERRAFORM_LATEST_VERSION}_linux_amd64.zip"
unzip terraform_${TERRAFORM_LATEST_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin

# Read AWS access key and secret key from provision.tf
AWS_ACCESS_KEY="AKIA6GIGQKYOPH5PYIP3"
AWS_SECRET_KEY="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"

# Configure AWS CLI
echo -e "$AWS_ACCESS_KEY\n$AWS_SECRET_KEY\nap-south-1\njson" | aws configure

# Change directory to eks folder
cd /home/ubuntu/eks

# Initialize Terraform
terraform init

# Validate Terraform configuration
terraform validate

# Apply Terraform changes
terraform apply --auto-approve

echo "Terraform setup and apply complete!"
