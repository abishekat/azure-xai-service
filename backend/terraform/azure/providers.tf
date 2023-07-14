terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "bucket-tfstate-test"
    key            = "state-file/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d143290a-4d5b-41d1-9223-a02a18155031"
}

provider "aws" {
  region = "us-east-1"
}
