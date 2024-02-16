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

output "cxcluster-arn" {
  value = aws_iam_role.cxcluster-k8s-access.arn
}

output "cxcluster-instance-profile" {
  value = aws_iam_instance_profile.cxcluster-access-profile.arn
}
