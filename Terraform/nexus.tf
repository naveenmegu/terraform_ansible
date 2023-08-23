resource "aws_instance" "nexus_tf" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.medium"
  key_name               = "terraform_ansible"
  vpc_security_group_ids = [aws_security_group.master_sg.id]

  tags = {
    Name = "nexus_server"
  }
}
