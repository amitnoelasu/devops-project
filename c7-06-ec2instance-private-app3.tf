
module "ec2-private-app3" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  for_each = local.multiple_instances

  name = "${local.name}-app3-multi-${each.key}"

  instance_type     = each.value.instance_type
  availability_zone = each.value.availability_zone
  vpc_security_group_ids = [module.private-sg.security_group_id]
  subnet_id         = each.value.subnet_id
  user_data = templatefile("app3-ums-install.tmpl", {rds_db_endpoint=module.db.db_instance_address})


  key_name = var.instance_keypair
  enable_volume_tags = false

  tags = local.common_tags
  depends_on = [ module.vpc, module.private-sg, module.ec2-public, module.db ]
}

