module "loadbalancer-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "loadbalancer-sg"
  description = "security group with HTTP port open for everybody (ipv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc.vpc_id

  # ingress rules
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp","https-443-tcp"]
  # egress rules
  egress_rules = ["all-all"]

  # ingress_with_cidr_blocks = [

  #   {
  #     from_port   = 81
  #     to_port     = 81
  #     protocol    = 6
  #     description = "Allow port 81 from internet"
  #     cidr_blocks = "0.0.0.0/0"
  #   }
  # ]

  tags = local.common_tags
}
