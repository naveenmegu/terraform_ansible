resource "aws_security_group" "master_sg" {
  name        = "master_sg"
  description = "Allow SSH,HHTP,HTTPS Traffic"


  ingress {
    description = "allow ssh"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_master"
  }
}
