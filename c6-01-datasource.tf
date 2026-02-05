data "aws_ami" "amz-linux2" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.9.20251208.0-kernel-6.1-x86_64*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}


# Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "valid-azs" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = data.aws_availability_zones.my_azones.names
    # values = ["us-east-1e"]
  }
  location_type = "availability-zone"
}

data "aws_acm_certificate" "CA" {
  domain   = var.domain-name
  statuses = ["ISSUED"]
}

