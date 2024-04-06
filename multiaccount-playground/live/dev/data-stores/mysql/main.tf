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
    key            = "444469924026/eu-west-1/data-store/mysql/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-444469924026-data-store-mysql-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
  # assume_role {
  #   role_arn = "arn:aws:iam::444469924026:role/admin-access-for-emrah-assumption"
  # }
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
