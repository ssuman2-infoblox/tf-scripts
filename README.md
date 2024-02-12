# AWS Infrastructure as Code
This repository contains Terraform scripts to create AWS infrastructure for the infoblox projects. 
It is only for the development, testing and PoC purposes.

# EKS Local Zone
> **WARNING:** This is a work in progress and is not yet ready for use.

This terraform script is used to create an EKS cluster with self-managed nodes in AWS Local Zone.

# Managed Host

This terraform script will create a managed host in the BiaB VPC and a Bastion host to access the MH in private subnet.
Update the terraform.tfvars file with the required values and run the below commands to create the infrastructure.

Once all resources are created, you can access the MH using the Bastion host.
To access the host, create or append the following configuration to your SSH config file (located at `~/.ssh/config`):

```sh
Host bastion-host
HostName <Public IP address of Bastion Host>
User ec2-user
Port 22
IdentityFile <path to key-pair pem file>
IdentitiesOnly yes
Host managed-host
HostName <Private IP address of Managed Host instance>
User root
Port 22
IdentityFile <path to key-pair pem file>
IdentitiesOnly yes
ProxyJump bastion-host
```

Then you can access the MH using the following command:
```sh
ssh managed-host
```
