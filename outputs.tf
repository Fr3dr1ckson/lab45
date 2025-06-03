output "public_ip" {
  value = aws_instance.web_server.public_ip
}

output "security_group_name" {
  value = aws_security_group.web_sg.name
}

output "instance_state" {
  value = aws_instance.web_server.instance_state
}
