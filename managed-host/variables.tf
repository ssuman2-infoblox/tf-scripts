variable "instance_name" {
  description = "The name of the server"
  type = string
  default = "tf_mh_instance"
}

variable "ami" {
  description = "The AMI to use for the server"
  type = string
  default = "ami-0e731c8a588258d0d"
}

variable "instance_type" {
  description = "The type of instance to use"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use"
  type = string
  default = ""
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the server in"
  type = string
  default = ""
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the server"
  type = list(string)
  default = []
}

variable "ec2_tags" {
  description = "A map of tags to assign to the server"
  type = map(string)
  default = {
    Source = "Terraform"
  }
}

variable "route53_zone" {
  description = "The Route53 zone to create a record in"
  type = string
  default = "managed.test.infoblox.com"
}
