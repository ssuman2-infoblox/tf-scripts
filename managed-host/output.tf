output "mh-instance-id" {
  value = aws_instance.sujay-tf-mh.id
}

output "bh-instance-id" {
  value = aws_instance.sujay-bastion-host.id
}

output "mh-private-dns" {
  value = aws_instance.sujay-tf-mh.private_dns
}

output "bh-public-dns" {
  value = aws_instance.sujay-bastion-host.public_dns
}
