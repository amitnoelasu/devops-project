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
