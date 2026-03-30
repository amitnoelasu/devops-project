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

variable "ssl-certificate-arn" {
  type = string
  description = "AWS ARN for TLS certificate issued by ACM"
}

variable "domain-name" {
  type = string
  description = "domain name for api"
}

# variable "my-access-key" {
#   type = string
#   description = "access key for AWS CLI"
# }

# variable "my-secret-key" {
#   type = string
#   description = "secret key for AWS CLI"
# }
