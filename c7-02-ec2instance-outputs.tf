# output "instance_public_ip" {
#   description = "ec2 instance public Ip"
#   value = aws_instance.my_ec2.public_ip
# }


# output "instance_public_dns" {
#   description = "ec2 instance public Ip"
#   value = aws_instance.my_ec2.public_dns
# }

# output "for_output_list" {
#   description = "for loop with list"
#   value = [for instance in aws_instance.my_ec2: instance.public_dns]
# }

# output "for_output_map" {
#   description = "for loop with map"
#   value = {for instance in aws_instance.my_ec2: instance.id => instance.public_dns}
# }

# output "for_output_map2" {
#   description = "for loop with map"
#   value = {for c, instance in aws_instance.my_ec2: c=> instance.public_dns}
# }


output "for_each_instance_ip" {
  description = "print instance ip"
  value = tomap({for az, instance in aws_instance.my_ec2: az => instance.public_dns})
}
# output "legacy_splat_instance_publicdns" {
#   description = "legacy splat operatorr"
#   value = aws_instance.my_ec2.*.public_dns
# }

# output "latest_splat_instance_publicdns" {
#   description = "generalized latest splat operatorr"
#   value = aws_instance.my_ec2[*].public_dns
# }




output "public_instance_id" {
  description = "The ID of the public/bastion instance"
  value       = module.ec2-public.id
}


output "public_instance_id_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2-public.public_dns
}

output "public_instance_id_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.ec2-public.public_ip
}



output "private_instance_ids" {
  description = "The ID of the public/bastion instance"
  value       = [for ec2private in module.module.ec2-private: ec2private.id]
}

// poublic ips wont exist for ec2 in private subnet
# output "private_instance_publicps" {
#   description = "The ID of the public/bastion instance"
#   value       = [for ec2private in module.module.ec2-private: ec2private.public_ip]
# }

output "private_instance_privateips" {
  description = "The ID of the public/bastion instance"
  value       = [for ec2private in module.module.ec2-private: ec2private.private_ip]
}