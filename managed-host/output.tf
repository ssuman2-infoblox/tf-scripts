output "mh-instance-id" {
  value = aws_instance.sujay-tf-mh.id
}

output "mh-instance-public-ip" {
  value = aws_instance.sujay-tf-mh.public_ip
}

output "mh-private-ip" {
  value = aws_instance.sujay-tf-mh.private_ip
}

output "bh-public-ip" {
  value = aws_instance.sujay-bastion-host.public_ip
}
