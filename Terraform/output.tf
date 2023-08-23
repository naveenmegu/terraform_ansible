output "public_ip_of_eks_server" {
  description = "this is the public IP"
  value       = aws_instance.eks_server.public_ip
}

output "private_ip_of_jenkins_server" {
  description = "this is the public IP"
  value       = aws_instance.jenkins_tf.public_ip
}

output "private_ip_of_nexus_server" {
  description = "this is the public IP"
  value       = aws_instance.nexus_tf.public_ip
}

output "private_ip_of_sonar_server" {
  description = "this is the public IP"
  value       = aws_instance.sonarqube_tf.public_ip
}