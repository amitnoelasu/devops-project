/**
        LOCALS
*/

# locals {
#   multiple_instances = {
#     one = {
#       instance_type     = "t3.micro"
#       availability_zone = element(module.vpc.azs, 0)
#       subnet_id         = element(module.vpc.private_subnets, 0)
#       root_block_device = {
#         encrypted  = true
#         type       = "gp3"
#         throughput = 200
#         size       = 50
#         tags = {
#           Name = "my-root-block"
#         }
#       }
#     }
#     two = {
#       instance_type     = "t3.small"
#       availability_zone = element(module.vpc.azs, 1)
#       subnet_id         = element(module.vpc.private_subnets, 1)
#       root_block_device = {
#         encrypted = true
#         type      = "gp2"
#         size      = 50
#       }
#     }
#     three = {
#       instance_type     = "t3.medium"
#       availability_zone = element(module.vpc.azs, 2)
#       subnet_id         = element(module.vpc.private_subnets, 2)
#     }
#   }
# }

/**
    VARIABLES
*/




variable "instance_type" {
  description = "type of instance to be created"
  type = string
  default = "t3.micro"
  sensitive = true
}

variable "instance-keypair" {
  description = "aws ec2 keypair for ec2 instance"
  type = string
  default = "terraform-ec2-kp"
}

//"subnet-0f98c1c895acf137a"

variable "subnet_id" {
  description = "target subnet for ec2"
  type = string
  default = "subnet-0f98c1c895acf137a"
}


// instance type - list
variable "instance_type_list" {
  description = "ec2 instance type list"
  type = list(string)
  default = [
    "t3.micro", "t3.small"
  ]
}


//instance type - map
variable "instance_type_map" {
  description = "ec2 instance type map"
  type = map(string)
  default = {
    "dev" = "t3.micro", 
    "qa" = "t3.small",
    "prod" = "t3.large"
  }
  
}

variable "private_instance_count" {
  description = "ec2 instance type map"
  type = number
  default = 1  
}