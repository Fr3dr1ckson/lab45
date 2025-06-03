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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                         = "ami-05d3e0186c058c4dd" 
  instance_type               = "t2.micro"
  key_name                    = "lab45"
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Lab45Instance"
  }
}
