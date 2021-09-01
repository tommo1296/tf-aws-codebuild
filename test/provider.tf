terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }

  backend "s3" {
    bucket          = "terraform-587510861408"
    key             = "tf-aws-codebuild.tfstate"
    region          = "eu-west-2"
    encrypt         = true
  }
}

provider "aws" {
  region = "eu-west-2"
}
