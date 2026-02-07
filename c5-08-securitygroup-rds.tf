module "rdsdb-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "rdsdb-sg"
  description = "security group with SSH and HTTP port open for everybody (ipv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc.vpc_id

  # ingress rules

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from private subnets"
      cidr_blocks = join(",", module.vpc.private_subnets_cidr_blocks)
    }
  ]


  # egress rules
  egress_rules = ["all-all"]
  tags = local.common_tags
}
