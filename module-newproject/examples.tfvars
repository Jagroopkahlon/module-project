name = "terraform_module"
instance_count = 2
ami_id = "ami-0b8b44ec9a8f90422"
instance_type = "t2.micro"
subnet1 = "subnet-0416af6e81cb5fdf4"
subnet2 = "subnet-060d04e5ac12c12f8"
key_name = "demo-key"
launch_template_name = "Module_LT"
security_groups = "sg-01a86b8886f23bcaa"
target_group_port = 80
vpc_id = "vpc-0cb71a01121b80660"
min_size = 2
max_size = 2


