terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "jagroop-singh-1993"
    key    = "terraformstate_file"
    region = "us-east-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}



# Variables
variable "launch_template_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "name" {}
variable "security_groups" {}
variable "target_group_port" {}
variable "vpc_id" {}
variable "instance_count" {}
variable "min_size" {}
variable "max_size" {}
variable "subnet1" {}
variable "subnet2" {}

#launch template
resource "aws_launch_template" "Launch_template_MODULE" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-launch-template"
    }
  }
}

#ALB
resource "aws_lb" "ALB-module" {
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet1, var.subnet2]
  security_groups    = [var.security_groups]
  
  tags = {
    Name = "alb"
  }
}

#target group
resource "aws_lb_target_group" "target_group_module" {
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#listener
resource "aws_lb_listener" "Listener_module" {
  load_balancer_arn = aws_lb.ALB-module.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_module.arn
  }
}

#ASG
resource "aws_autoscaling_group" "ASG_module" {
  launch_template {
    id = aws_launch_template.Launch_template_MODULE.id
  }

  desired_capacity      = var.instance_count
  min_size              = var.min_size
  max_size              = var.max_size
  vpc_zone_identifier   = [var.subnet1, var.subnet2]
  target_group_arns = [ aws_lb_target_group.target_group_module.arn ]
}
