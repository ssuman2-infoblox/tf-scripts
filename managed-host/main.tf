provider "aws" {
  region = "us-east-1"
}

data "aws_iam_instance_profile" "eks-access" {
  name = "haas-dev-test"
}

resource "aws_instance" "sujay-tf-mh" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = var.security_groups
  user_data = file("userdata.yaml")
  iam_instance_profile = data.aws_iam_instance_profile.eks-access.name
  tags = {
      Name = "sujay-tf-mh"
  }
}

resource "aws_eip" "mh-eip" {
  network_border_group = "us-east-1"
  public_ipv4_pool = "amazon"
}

resource "aws_eip_association" "associate-mh-eip" {
    instance_id   = aws_instance.sujay-tf-mh.id
    allocation_id = aws_eip.mh-eip.id
}

data "aws_route53_zone" "managed" {
  name         = var.route53_zone
  private_zone = false
}

resource "aws_route53_record" "tf-test-record" {
  zone_id = data.aws_route53_zone.managed.zone_id
  name    = "mhtesttf0.${data.aws_route53_zone.managed.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.mh-eip.public_ip]
}
