module "public-bastion-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "public-bastion-sg"
  description = "security group with SSH port open for everybody (ipv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc.vpc_id

  # ingress rules
  ingress_cidr_blocks = [var.my_ip]
  ingress_rules       = ["ssh-tcp"]
  # egress rules
  egress_rules = ["all-all"]
  tags = local.common_tags
}
