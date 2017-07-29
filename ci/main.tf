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
  access_key = "A32281872C9981C89218"
  secret_key = "W8r2kQHm1wbpiFeGpL7EC2eYLt3T1qqi9wRF49BJ"
}

variable "rancher_api_access_key" {
  type = "string"
}
variable "rancher_api_secret_key" {
  type = "string"
}