resource "aws_instance" "eks_server" {
  ami                         = var.os_name
  key_name                    = var.key
  instance_type               = var.instance-type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.master_sg.id]

  tags = {
    Name = "eks_master_server"
  }
}

// Create VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc-cidr
}

// Create Subnet
resource "aws_subnet" "eks_subnet_1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.subnet1-cidr
  availability_zone       = var.subnet1_az
  map_public_ip_on_launch = "true"

  tags = {
    Name = "eks_subnet_1"
  }
}

resource "aws_subnet" "eks_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.subnet2-cidr
  availability_zone       = var.subnet2_az
  map_public_ip_on_launch = "true"

  tags = {
    Name = "eks_subnet_2"
  }
}

// Create Internet Gateway

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks_igw"
  }
}

resource "aws_route_table" "eks_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
  tags = {
    Name = "eks_rt"
  }
}

// associate subnet with route table 
resource "aws_route_table_association" "eks_rt_association_1" {
  subnet_id      = aws_subnet.eks_subnet_1.id
  route_table_id = aws_route_table.eks_rt.id
}

// associate subnet with route table 
resource "aws_route_table_association" "eks_rt_association_2" {
  subnet_id      = aws_subnet.eks_subnet_2.id
  route_table_id = aws_route_table.eks_rt.id
}

module "sgs" {
  source = "./sg_eks"
  vpc_id = aws_vpc.eks_vpc.id
}

module "eks" {
  source     = "./eks"
  sg_ids     = module.sgs.security_group_public
  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id]
}




