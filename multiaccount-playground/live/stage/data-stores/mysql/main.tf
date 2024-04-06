terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-813271427490-multiaccount-bucket"
    key            = "813271427490/eu-west-1/data-store/mysql/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-813271427490-data-store-mysql-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
