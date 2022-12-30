provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "org-m5BhVqqgU3fsJaoj"

    workspaces {
      name = "cloud3"
    }
  }
}

