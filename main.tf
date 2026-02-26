terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "backend_server" {
  ami = "ami-0b6c6ebed2801a5cb" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "grotrack-backend"
  }
}

resource "aws_instance" "frontend_server" {
  ami = "ami-0b6c6ebed2801a5cb" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "grotrack-frontend"
  }
}

resource "aws_instance" "frontend_load_balancer" {
  ami = "ami-0b6c6ebed2801a5cb" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "grotrack-frontend-load-balancer"
  }
}

resource "aws_instance" "bd_server" {
  ami = "ami-0b6c6ebed2801a5cb" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "grotrack-bd"
  }
}

resource "aws_instance" "api_groq_server" {
  ami = "ami-0b6c6ebed2801a5cb" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "grotrack-api-groq"
  }
}