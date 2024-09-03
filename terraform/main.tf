provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  pub_subnets  = var.public_subnets
  priv_subnets = var.private_subnets
}


module "ec2" {
  source            = "./modules/ec2"
  sg_vpc_id         = module.vpc.vpc_id
  ec2_subnet_id     = module.vpc.public_subnets_id[0]
  instance_profile  = module.eks.eks_profile

}

module "eks" {
  source                 = "./modules/eks"
  eni_subnet_ids         = module.network.private_subnets_id
  nodegroup_subnets_id   = module.network.private_subnets_id
}