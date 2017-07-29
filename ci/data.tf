data "terraform_remote_state" "arsdehnel_shared" {
  backend = "s3"

  config {
    bucket = "arsdehnel-terraform"
    key    = "arsdehnel/shared.tfstate"
    region = "us-west-2"
  }
}