terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Call VPC Module
module "vpc" {
  source      = "../../modules/vpc"
  environment = "dev"
}

# 2. Call RDS Module (Consumes VPC private subnets)
module "rds" {
  source             = "../../modules/rds"
  environment        = "dev"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_password        = var.db_password
}

# 3. Call ECS Module (Consumes VPC public subnet)
module "ecs" {
  source           = "../../modules/ecs"
  environment      = "dev"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}