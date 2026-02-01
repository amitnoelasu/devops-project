variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type = string
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
}

variable "business_division" {
  description = "Business Division in the large organization this "
  type = string
  default = "HR"
}

variable "my_ip" {
  description = "My public IP in CIDR format"
  type        = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "instance_keypair" {
  type        = string
  description = "Existing EC2 key pair name in AWS (us-east-1)"
}
