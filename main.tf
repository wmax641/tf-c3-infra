# Comment
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
    organization = "wmax641"

    workspaces {
      name = "cloud3"
    }
  }
}

