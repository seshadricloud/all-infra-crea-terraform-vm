variable "az" {
  description = "List of availability zones"
  type        = list(string)
}

variable "publicsubnet" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "privatesubnet" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "datasubnet" {
  description = "List of data subnet CIDR blocks"
  type        = list(string)
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instances"
  type        = string
}

variable "ami_ubuntu" {
  description = "AMI ID for Ubuntu instances"
  type        = string
}

variable "type_ubuntu" {
  description = "Instance type for Ubuntu instances"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "type" {
  description = "Instance type"
  type        = string
}

variable "type_small" {
  description = "Instance type for small instances"
  type        = string
}
