variable "location" {
  default = "ap-south-1"
}

variable "os_name" {
  default = "ami-0f5ee92e2d63afc18"
}

variable "key" {
  default = "terraform_ansible"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "subnet1-cidr" {
  default = "10.0.1.0/24"

}

variable "subnet2-cidr" {
  default = "10.0.2.0/24"

}

variable "subnet1_az" {
  default = "ap-south-1a"
}

variable "subnet2_az" {
  default = "ap-south-1b"
}