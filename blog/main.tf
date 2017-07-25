provider "aws" {
  region = "${var.aws_region}"
  profile = "arsdehnel"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "blog"
}
terraform {
  backend "s3" {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/blog.tfstate"
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

resource "aws_route53_record" "gh_pages" {
  zone_id = "${data.terraform_remote_state.arsdehnel_shared.r53_zone_id}"
  name    = "blog.arsdehnel.ninja"
  type    = "CNAME"
  ttl     = "300"
  records = ["arsdehnel.github.io"]
}

resource "aws_ecr_repository" "arsdehnel_blog_dev_env" {
  name = "arsdehnel-blog-dev-env"
}
