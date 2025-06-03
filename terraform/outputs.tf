output "public_ip" {
  value = data.aws_instance.web_server.public_ip
}

output "security_group_name" {
  value = data.aws_security_group.web_sg.name
}

output "instance_state" {
  value = data.aws_instance.web_server.instance_state
}