// Terraform block
terraform {
  required_version = "1.14.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.28.0"
    }

    null = {
      source = "hashicorp/null"
      version = "~> 3.2.4"
    }

    random = {
      source = "hashicorp/random"
      version = "~> 3.8.1"
    }

  }
}

// Provider block
provider "aws" {
  region = var.aws_region
}

provider "null" {
  # Configuration options
}

// for notifications ASG
resource "random_pet" "this" {
  length = 2
}
