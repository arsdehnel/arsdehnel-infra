module "rancher-server" {
  source = "/Users/dehnel/Projects/cpd/terraform-modules//rancher-server/2"

  environment = "${var.environment}"
  application = "rancher"
  bill_code   = "${var.environment}"
  subdomain   = "rancher-np"
  region      = "us-west-2"
  count       = 1
  rds_instance_class = "db.t2.small"
  ami         = "ami-bed0c7c7"  # v1.0.3
  vpc_id      = "${module.vpc.vpc_id}"
  subnet_ids  = ["${module.vpc.public_subnets}"]
  r53_zone_id = "${data.terraform_remote_state.arsdehnel_shared.r53_zone_id}"
  key_name    = "arsdehnel"
  db_pass     = "${var.rancher_db_pwd}"
  cert_arn    = "${data.terraform_remote_state.arsdehnel_shared.arsdehnel_ninja_cert_arn}"
}
