terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.72.1"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    tags = {
        Name = "ec2-docker-deploy"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo systemctl enable docker
                sudo systemctl start docker
                docker run -d -p 80:80 ${var.docker_image}
                EOF



    } 
variable "docker_image" {
    description = "Docker image to deploy"
    type = string  
}
