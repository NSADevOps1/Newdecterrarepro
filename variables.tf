# Configure the AWS Provider variables
variable "region_aws" {
  default = "eu-west-2"
}

# Create a VPC variables
variable "cidr_block" {
  description = "cidr for vpc-dec"
  default     = "10.0.0.0/16"
}

# Create public subnets variables
variable "Dec-pub-sub1-cidr_block" {
  description = "Dec-pub-sub1"
  default     = "10.0.1.0/24"
}

variable "Dec-pub-sub2-cidr_block" {
  description = "Dec-pub-sub2"
  default     = "10.0.2.0/24"
}

# Create private subnets variables
variable "Dec-priv-sub1-cidr_block" {
  description = "Dec-priv-sub1"
  default     = "10.0.3.0/24"
}

variable "Dec-priv-sub2-cidr_block" {
  description = "Dec-priv-sub2"
  default     = "10.0.4.0/24"
}

# Create public route table
variable "aws_route_table-Dec-route-pub" {
  description = "aws_route_table.Dec-route-pub"
  default     = "0.0.0.0/0"
}

# Create security group
variable "aws_security_group-Dec-sec-group1" {
  default     = "Allow HTTP and SSH traffic via Terraform 80"
  description = "aws_security_group-Dec-sec-group1"

}

variable "aws_security_group-Dec-sec-group2" {
  default     = "Allow HTTP and SSH traffic via Terraform 22"
  description = "aws_security_group-Dec-sec-group2"
}

# Create  EC2 Instance
variable "aws_instance_Dec-server-pub" {
  default     = "ami-0f540e9f488cfa27d"
  description = "aws_instance_Dec-server-pub"

}

variable "aws_instance_Dec-server-priv" {
  default     = "ami-0f540e9f488cfa27d"
  description = "aws_instance_Dec-server-priv"

}
