#!/bin/bash

# Install or update kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mkdir -p /home/ubuntu/bin
sudo cp ./kubectl /home/ubuntu/bin/kubectl
export PATH=/home/ubuntu/bin:$PATH
echo 'export PATH=/home/ubuntu/bin:$PATH' >> ~/.bashrc
source /home/ubuntu/.bashrc
kubectl version --client
sleep 5  # Sleep for 5 seconds

# Install or update eksctl
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
sudo tar -xzf eksctl_Linux_amd64.tar.gz
sudo mv eksctl /usr/local/bin
rm eksctl_Linux_amd64.tar.gz
eksctl version
sleep 5  # Sleep for 5 seconds

# Install or update AWS CLI
sudo apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo rm awscliv2.zip
aws --version
sleep 5  # Sleep for 5 seconds

# Read AWS access key and secret key from provision.tf
AWS_ACCESS_KEY="<access_key>"
AWS_SECRET_KEY="<secret_key>"

# Configure AWS CLI
echo -e "$AWS_ACCESS_KEY\n$AWS_SECRET_KEY\nap-south-1\njson" | aws configure

aws sts get-caller-identity

# Install the latest version of Terraform
TERRAFORM_LATEST_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep "tag_name" | cut -d'"' -f4 | cut -d'v' -f2)
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_LATEST_VERSION}/terraform_${TERRAFORM_LATEST_VERSION}_linux_amd64.zip"
unzip terraform_${TERRAFORM_LATEST_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin
sudo rm terraform_${TERRAFORM_LATEST_VERSION}_linux_amd64.zip
terraform --version
sleep 5  # Sleep for 5 seconds

# Change directory to eks folder
cd /home/ubuntu/eks

# Initialize Terraform
terraform init

# Format Terraform
terraform fmt

# Validate Terraform configuration
terraform validate

AWS_ACCESS_KEY="<access_key>"
AWS_SECRET_KEY="<secret_key>"

# Configure AWS CLI
echo -e "$AWS_ACCESS_KEY\n$AWS_SECRET_KEY\nap-south-1\njson" | aws configure

# Apply Terraform changes
terraform apply --auto-approve

echo "Terraform setup and apply complete!"



