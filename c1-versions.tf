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

  backend "s3" {
    bucket = "terraform-aws-for-ec2-99"
    key    = "dev/project1-vpc/terraform.tfstate"
    region = "us-east-1" 

    # Enable during Step-09     
    # For State Locking
    dynamodb_table = "dev-project1-vpc"    
  }    

}

// Provider block
provider "aws" {
  region = var.aws_region
  # secrets passed through env variables for codeBuild
  # access_key = var.my-access-key
  # secret_key = var.my-secret-key

}

provider "null" {
  # Configuration options
}

// for notifications ASG
resource "random_pet" "this" {
  length = 2
}
