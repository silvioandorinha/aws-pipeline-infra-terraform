# base
terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# resources

# S3 Bucket
resource "aws_s3_bucket" "meu-bucket-aws" {
  bucket = "meu-bucket-aws"
}

# EC2
resource "aws_cloud9_environment_ec2" "minha-instancia-ec2" {
  instance_type = "t2.micro"
  name          = "minha-maquina"
  image_id      = "amazonlinux-1-x86_64"
}