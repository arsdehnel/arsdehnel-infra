module "rancher_env" {
  source           = "/Users/dehnel/Projects/cpd/terraform-modules//rancher-environment/2"
  application      = "rancher"
  environment      = "ci"
  bill_code        = "rancher-ci"
  description      = "CI tools and resources"
  vpc_id           = "${data.terraform_remote_state.arsdehnel_shared.vpc_id}"
  r53_zone_id      = "${data.terraform_remote_state.arsdehnel_shared.r53_zone_id}"
  key_name         = "arsdehnel"
  instance_profile = "${data.terraform_remote_state.arsdehnel_shared.rancher_host_instance_profile_name}"

  security_groups  = [
    "${data.terraform_remote_state.arsdehnel_shared.vpc_default_security_group_id}",
    "${data.terraform_remote_state.arsdehnel_shared.rancher_db_security_group}",
  ]

  elb_subnet_ids   = [
    "${data.terraform_remote_state.arsdehnel_shared.public_subnet_ids}",
  ]

  cert_arn         = "${data.terraform_remote_state.arsdehnel_shared.arsdehnel_ninja_cert_arn}"
}
