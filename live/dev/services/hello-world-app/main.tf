terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
    backend "s3" {
    bucket         = "terraform-state-444469924026-multiaccount-bucket"
    key            = "444469924026/eu-west-1/services/hello-world/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-444469924026-services-hello-world-state-locking"
    encrypt        = true
  }
}


provider "aws" {
  region = "eu-west-1"
  # assume_role {
  #   role_arn = var.arn:aws:iam::444469924026:role/admin-access-for-emrah-assumption
  # }
}


module "hello_world_app" {

  source = "git::https://github.com/EmrhT/terraform-child-modules.git//services/hello-world-app?ref=v1.0.0"

  server_text = var.server_text

  environment            = var.environment
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
  ami                = data.aws_ami.ubuntu.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
