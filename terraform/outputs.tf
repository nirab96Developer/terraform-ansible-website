output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.web_server.public_ip
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.web_eip.public_ip
}

output "website_url" {
  description = "Website URL"
  value       = "http://${aws_eip.web_eip.public_ip}"
}

output "ssh_connection_command" {
  description = "SSH connection command"
  value       = "ssh -i ${var.private_key_path} ubuntu@${aws_eip.web_eip.public_ip}"
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}
