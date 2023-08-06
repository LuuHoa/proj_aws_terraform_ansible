provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "proj_aws" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu
  instance_type = "t2.micro"
  key_name      = "proj_aws_terraform_ansible"

  security_groups = [aws_security_group.proj_aws_allow_ssh_tcp.name]

  tags = {
    Name = "Terraform_Initiation_EC2"
  }
}

resource "aws_security_group" "proj_aws_allow_ssh_tcp" {
  name        = "allow-ssh-tcp"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
