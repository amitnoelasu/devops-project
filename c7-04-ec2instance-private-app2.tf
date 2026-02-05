
module "ec2-private-app2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  for_each = local.multiple_instances

  name = "${local.name}-app2-multi-${each.key}"

  instance_type     = each.value.instance_type
  availability_zone = each.value.availability_zone
  vpc_security_group_ids = [module.private-sg.security_group_id]
  subnet_id         = each.value.subnet_id
  user_data = file("${path.module}/app2-install.sh")


  key_name = var.instance_keypair
  enable_volume_tags = false
#   root_block_device  = try(each.value.root_block_device, null)

  tags = local.common_tags
  depends_on = [ module.vpc, module.private-sg, module.ec2-public ]
}

# module "ec2-private" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "6.2.0"
  
#   name = "${var.environment}-BastionHost"

#   ami                    = data.aws_ami.amz-linux2.id
#   instance_type          = var.instance_type_map["dev"] # used to set core count below
#   availability_zone      = element(module.vpc.azs, 0)
#   subnet_id              = element(module.vpc.private_subnets, 0)
#   vpc_security_group_ids = [module.private_security_group_id]
# #   placement_group        = aws_placement_group.web.id
# #   create_eip             = true
# #   disable_api_stop       = false
#   tags = local.common_tags

# #   create_iam_instance_profile = true
# #   iam_role_description        = "IAM role for EC2 instance"
# #   iam_role_policies = {
# #     AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
# #   }
# }