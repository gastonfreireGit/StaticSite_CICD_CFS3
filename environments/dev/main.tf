terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
    default_tags {
    tags = {
      createdby = var.createdby
      project   = var.project
    }
  }
}

module "s3_module" {
  source  = "../../modules/s3-module"
  s3_name = var.s3_name
}

module "cf_module" {
  source = "../../modules/cf-module"
  s3_name = var.s3_name
  depends_on = [
    module.s3_module
  ]
}

module "cp_module" {
  source      = "../../modules/cp-module"
  s3_name = var.s3_name
}