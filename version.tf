terraform {
    required_version = ">=1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=5.82.2"
    }
  }
}
provider "aws" {
  # Configuration options
  region = "ap-south-1"
  
}