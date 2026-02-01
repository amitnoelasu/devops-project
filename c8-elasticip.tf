resource "aws_eip" "bastion_host_eip" {
    depends_on = [ module.vpc, module.ec2-public ]
    instance = module.ec2-public.id
    domain   = "vpc"
    tags = local.common_tags
}

output "bastion_eip" {
  value = aws_eip.bastion_host_eip.public_ip
}
