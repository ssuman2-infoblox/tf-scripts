# General
variable "key_name" {
  description = "The name of the key pair to use"
  type = string
  default = ""
}
variable "private_subnet_id" {
  description = "The ID of the subnet to launch the server in"
  type = string
  default = ""
}
variable "public_subnet_id" {
  description = "The ID of the subnet to launch the server in"
  type = string
  default = ""
}
variable "route53_zone" {
  description = "The Route53 zone to create a record in"
  type = string
  default = "managed.test.infoblox.com"
}

# Managed Host
variable "mh_name" {
  description = "The name of the server"
  type = string
  default = "tf_mh_instance"
}
variable "mh_ami" {
  description = "The AMI to use for the server"
  type = string
  default = "ami-0e731c8a588258d0d"
}
variable "mh_instance_type" {
  description = "The type of instance to use"
  type = string
  default = "t2.micro"
}
variable "mh_security_groups" {
  description = "A list of security group IDs to associate with the server"
  type = list(string)
  default = []
}
variable "mh_tags" {
  description = "A map of tags to assign to the server"
  type = map(string)
  default = {
    Source = "Terraform"
  }
}

# Bastion Host
variable "bh_name" {
  description = "The name of the bastion host"
  type = string
  default = "tf_bh_instance"
}
variable "bh_ami" {
    description = "The AMI to use for the bastion host"
    type = string
    default = "ami-0e731c8a588258d0d"
}
variable "bh_instance_type" {
  description = "The type of instance to use"
  type = string
  default = "t2.micro"
}
variable "bh_security_groups" {
  description = "A list of security group IDs to associate with the server"
  type = list(string)
  default = []
}
variable "bh_tags" {
  description = "A map of tags to assign to the server"
  type = map(string)
  default = {
    Source = "Terraform"
  }
}

