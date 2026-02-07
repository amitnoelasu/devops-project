module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "private-sg"
  description = "security group with SSH and HTTP port open for everybody (ipv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc.vpc_id

  # ingress rules
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "http-8080-tcp"]
  # egress rules
  egress_rules = ["all-all"]
  tags = local.common_tags
}
