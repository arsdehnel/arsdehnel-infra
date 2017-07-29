output "r53_zone_id" {
  value = "${aws_route53_zone.main.id}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnets}"
}

output "arsdehnel_ninja_cert_arn" {
  value = "${data.aws_acm_certificate.arsdehnel_ninja.arn}"
}

output "vpc_default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "rancher_db_security_group" {
  value = "${module.rancher_server.db_security_group}"
}

output "rancher_host_instance_profile_name" {
  value = "${module.rancher_server.host_instance_profile_name}"
}