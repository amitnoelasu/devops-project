resource "aws_eip" "bastion_host_eip" {
    depends_on = [ module.vpc, module.ec2-public ]
    instance = module.public_instance_id
    domain   = "vpc"
    tags = local.common_tags
}

