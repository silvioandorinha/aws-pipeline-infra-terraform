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
data "aws_caller_identity" "current" {}

# S3 Bucket
resource "aws_s3_bucket" "meu-bucket-aws" {
  bucket = "meu-bucket-aws"
}

# EC2
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "minha-instancia-ec2-ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "minha-instancia-ec2-ubuntu"
  }
}

# SQS
resource "aws_sqs_queue" "minha_fila_sqs" {
  name                      = "minha-fila-sqs"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "dev"
  }
}

# KMS
resource "aws_kms_key" "minha_chave_kms" {
  description             = "An example symmetric encryption KMS key"
  enable_key_rotation     = true
  deletion_window_in_days = 20

  tags = {
    Name        = "minha-chave-kms"
    Environment = "dev"
  }
}