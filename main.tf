provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "iitnatkoslab6"
    key    = "lab45/terraform/terraform.tfstate"
    region = "eu-west-2"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "lab45-web-sg"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                         = "ami-05d3e0186c058c4dd"
  instance_type               = "t3.micro"
  key_name                    = "lab6"
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker

              # Run your Docker image
              docker run -d --name myapp -p 80:80 fr3dr1ckson/lab45:latest

              # Run Watchtower with 60s interval
              docker run -d \
                --name watchtower \
                --restart always \
                -v /var/run/docker.sock:/var/run/docker.sock \
                containrrr/watchtower \
                --interval 60 \
                --cleanup
              EOF

  tags = {
    Name = "Lab45Instance"
  }
}
