variable "name" {
    description = "name to be created for resources"
    type = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "subnet1" {
  type = object({
    id = string
    // Other attributes as needed
  })
}

variable "subnet2" {
  type = object({
    id = string
    // Other attributes as needed
  })
}



variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "launch_template_name" {
  description = "Name prefix for the launch template"
  type        = string
}

variable "min_size" {
  description = "Minimum size for the auto scaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size for the auto scaling group"
  type        = number
  default     = 2
}


variable "security_groups" {
  description = "Security group ID for the Application Load Balancer"
  type        = string
}


variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}


variable "vpc_id" {
  description = "VPC ID for the Application Load Balancer"
  type        = string
}
