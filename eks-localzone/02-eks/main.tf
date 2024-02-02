provider "aws" {
  region = "us-east-1"

}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    }
  }
}

locals {
  name   = basename(path.cwd)
  region = "us-east-1"
}


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.16"

  cluster_name                   = var.cluster_name
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    mg_5 = {
      instance_types = ["m5.large"]
      min_size     = 1
      max_size     = 3
      subnet_ids   = var.private_subnets
    }
  }

  self_managed_node_groups = {
    # Bottlerocket node group
    self_mg_4 = {
      name = "self-managed-ondemand"
      platform      = "bottlerocket"
      instance_type = "m5.large"
      ami_id = "ami-070f54df448b5ba72"
      min_size  = 1
      max_size  = 3
      block_device_mappings = [
        {
          device_name = "/dev/xvda"
          volume_type = "gp3"
          volume_size = "100"
        },
      ]
      enable_monitoring = false
      subnet_ids = [var.private_subnets_local_zone]
    }
  }
}

resource "aws_security_group_rule" "allow_node_sg_to_cluster_sg" {
  description = "Self-managed Nodegroup to Cluster API/Managed Nodegroup all traffic"

  source_security_group_id = module.eks.node_security_group_id
  security_group_id        = module.eks.cluster_primary_security_group_id
  type                     = "ingress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0

  depends_on = [
    module.eks
  ]
}

resource "aws_security_group_rule" "allow_node_sg_from_cluster_sg" {
  description = "Cluster API/Managed Nodegroup to Self-Managed Nodegroup all traffic"
  source_security_group_id = module.eks.cluster_primary_security_group_id
  security_group_id        = module.eks.node_security_group_id
  type                     = "ingress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0

  depends_on = [
    module.eks
  ]
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${local.region} --name ${module.eks.cluster_id}"
  }

  depends_on = [
    module.eks
  ]
}