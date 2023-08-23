resource "aws_instance" "jenkins_tf" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.micro"
  key_name               = "terraform_ansible"
  vpc_security_group_ids = [aws_security_group.master_sg.id]

  tags = {
    Name = "jenkins_master_server"
  }
}
