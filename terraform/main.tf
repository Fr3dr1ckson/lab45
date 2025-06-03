provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "iitnatkoslab6"
    key    = "lab45/terraform/terraform.tfstate"
    region = "eu-west-2"
  }
}

data "aws_key_pair" "deployer" {
  key_name = "lab45"
}

data "aws_security_group" "web_sg" {
  id = "sg-05780b3263dc33056"
}

data "aws_instance" "web_server" {
  instance_id = "i-0ea450bf27db0b30f"
}