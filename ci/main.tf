terraform {
  backend "s3" {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/ci.tfstate"
    region = "us-west-2"
  }
}

variable "aws_region" {
  default = "us-west-2"
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "arsdehnel"
}

provider "rancher" {
  api_url    = "https://rancher.arsdehnel.ninja"
  access_key = "${var.rancher_api_access_key}"
  secret_key = "${var.rancher_api_secret_key}"
}

variable "rancher_api_access_key" {
  type = "string"
}
variable "rancher_api_secret_key" {
  type = "string"
}