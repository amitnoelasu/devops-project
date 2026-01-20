// public sg
output "public_bastion_security_group_id" {
  description = "The ID of the security group"
  value       = module.public-bastion-sg.security_group_id
}

output "public_bastion_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public-bastion-sg.security_group_vpc_id
}

output "public_bastion_security_group_owner_id" {
  description = "The owner ID"
  value       = module.public-bastion-sg.security_group_owner_id
}

output "public_bastion_security_group_name" {
  description = "The name of the security group"
  value       = module.public-bastion-sg.security_group_name
}

// private sg
output "private_security_group_id" {
  description = "The ID of the security group"
  value       = module.private-sg.security_group_id
}

output "private_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private-sg.security_group_vpc_id
}

output "private_security_group_owner_id" {
  description = "The owner ID"
  value       = module.private-sg.security_group_owner_id
}

output "private_bastion_security_group_name" {
  description = "The name of the security group"
  value       = module.private-sg.security_group_name
}

