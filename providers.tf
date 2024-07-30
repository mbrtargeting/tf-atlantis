terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.8"
    }
  }
}

data "aws_caller_identity" "current" {}
