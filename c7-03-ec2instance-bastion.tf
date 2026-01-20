# resource "aws_instance" "my_ec2" {
#   ami = data.aws_ami.amz-linux2.id
#   // instance_type = var.instance_type_list[0]
#   instance_type = var.instance_type_map["dev"]

#   # subnet_id = var.subnet_id
#   associate_public_ip_address = true
#   key_name = var.instance-keypair
#   vpc_security_group_ids = [aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id]
#   user_data = file("${path.module}/app1-install.sh")

#   for_each = toset(data.aws_ec2_instance_type_offerings.valid-azs.locations)
#   availability_zone = each.key
#   # count = 3 
#   tags = {
#     "Name" = "Ec2 for-each-Demo-${each.value}"
#   }
# }

module "ec2-public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"
  
  name = "${var.environment}-BastionHost"

  ami                    = data.aws_ami.amz-linux2.id
  instance_type          = var.instance_type_map["dev"] # used to set core count below
  availability_zone      = element(module.vpc.azs, 0)
#   subnet_id              = element(module.vpc.public_subnets, 0)
  
  vpc_security_group_ids = [module.public_bastion_security_group_id]
#   placement_group        = aws_placement_group.web.id
#   create_eip             = true
#   disable_api_stop       = false
  tags = local.common_tags

#   create_iam_instance_profile = true
#   iam_role_description        = "IAM role for EC2 instance"
#   iam_role_policies = {
#     AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
#   }
}