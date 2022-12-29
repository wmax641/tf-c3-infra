provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  backend "local" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

