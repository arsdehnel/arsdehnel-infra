module "rancher_server" {
  source = "/Users/dehnel/Projects/cpd/terraform-modules//rancher-server/3"

  environment = "${var.environment}"
  application = "rancher"
  bill_code   = "${var.environment}"
  subdomain   = "rancher"
  aws_region  = "us-west-2"
  count       = 1
  rds_instance_class = "db.t2.small"
  ami         = "ami-bed0c7c7"  # rancheros v1.0.3
  instance_type = "t2.small"
  vpc_id      = "${module.vpc.vpc_id}"
  subnet_ids  = ["${module.vpc.public_subnets}"]
  asg_security_groups = [ "${module.vpc.default_security_group_id}" ]
  r53_zone_id = "${aws_route53_zone.main.id}"
  key_name    = "arsdehnel"
  db_pass     = "${var.rancher_db_pwd}"
  cert_arn    = "${data.aws_acm_certificate.arsdehnel_ninja.arn}"
}
