provider "aws" {
  region = "${var.aws_region}"
  profile = "arsdehnel"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "shared"
}
terraform {
  backend "s3" {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/shared.tfstate"
    region = "us-west-2"
  }
}

# from .tfvars files
variable "public_key_path" {}

resource "aws_route53_zone" "main" {
  name = "arsdehnel.ninja"

  tags {
    environment = "${var.environment}"
  }
}

data "aws_acm_certificate" "arsdehnel_ninja" {
  domain = "arsdehnel.ninja"

  # includes these:
  # *.arsdehnel.ninja
  # *.dev.arsdehnel.ninja

  statuses = ["ISSUED"]
}

output "r53_zone_id" {
  value = "${aws_route53_zone.main.id}"
}

output "arsdehnel_ninja_cert_arn" {
  value = "${data.aws_acm_certificate.arsdehnel_ninja.arn}"
}

resource "aws_key_pair" "arsdehnel" {
  key_name   = "cpd"
  public_key = "${file("${var.public_key_path}")}"
}