provider "aws" {
  region = "${var.aws_region}"
  profile = "arsdehnel"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "non-prod"
}

# from .tfvars files
variable "rancher_db_pwd" {}

terraform {
  backend "s3" {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/shared-non-prod.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "arsdehnel_shared" {
  backend = "s3"

  config {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/shared.tfstate"
    region = "us-west-2"
  }
}


module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "vpc-${var.environment}"

  cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  azs      = ["us-west-2a", "us-west-2b", "us-west-2c"]

  tags {
    "terraform" = "true"
    "environment" = "${var.environment}"
  }
}