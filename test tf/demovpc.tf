provider "aws" {  
  region = "us-east-1"  
}  
resource "aws_vpc" "main" {  
  cidr_block = "10.0.0.0/16"  
}  
resource "aws_security_group" "mytestserver_sg" {  
  name        = "my_test_server_sg"  
  description = "Testing Dynamic Block"  
  vpc_id      = aws_vpc.main.id  
  dynamic "ingress" {  
    for_each = var.websgrules  
    content {  
      from_port   = ingress.value["port"]  
      to_port     = ingress.value["port"]  
      protocol    = ingress.value["protocol"]  
      cidr_blocks = ingress.value["cidr_blocks"]  
    }  
  }  
  dynamic "ingress" {  
    for_each = var.managementsgrules  
    content {  
      from_port   = ingress.value["port"]  
      to_port     = ingress.value["port"]  
      protocol    = ingress.value["protocol"]  
      cidr_blocks = ingress.value["cidr_blocks"]  
    }  
  }  
  dynamic "egress" {  
    for_each = var.websgrules  
    content {  
      from_port   = egress.value["port"]  
      to_port     = egress.value["port"]  
      protocol    = egress.value["protocol"]  
      cidr_blocks = egress.value["cidr_blocks"]  
    }  
  }  
}  
variable "websgrules" {  
  default = [  
    {  
      port        = 80  
      protocol    = "tcp"  
      cidr_blocks = ["0.0.0.0/0"]  
    },  
    {  
      port        = 443  
      protocol    = "tcp"  
      cidr_blocks = ["0.0.0.0/0"]  
    }  
  ]  
}  
variable "managementsgrules" {  
  default = [  
    {  
      port        = 22  
      protocol    = "tcp"  
      cidr_blocks = ["0.0.0.0/0"]  
    }  
  ]  
}