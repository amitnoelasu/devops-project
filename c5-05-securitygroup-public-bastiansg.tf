module "public-bastion-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "public-bastion-sg"
  description = "security group with SSH port open for everybody (ipv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc_id

  # ingress rules
  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["ssh-22-tcp"]
  # egress rules
  egress_rules = ["all-all"]
  tags = local.common_tags
}
