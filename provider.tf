terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
  alias   = "apse1"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias   = "usw1"
}

data "aws_caller_identity" "this" {}

data "aws_ecr_authorization_token" "token" {
  
}

data "aws_ecr_authorization_token" "token-apse1" {
  provider = aws.apse1
}

data "aws_ecr_authorization_token" "token-usw1" {
  provider = aws.usw1
}

provider "docker" {
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "ap-south-1")
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}

provider "docker" {
  alias   = "apse1"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "ap-southeast-1")
    username = data.aws_ecr_authorization_token.token-apse1.user_name
    password = data.aws_ecr_authorization_token.token-apse1.password
  }
}

provider "docker" {
  alias   = "usw1"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "us-west-1")
    username = data.aws_ecr_authorization_token.token-usw1.user_name
    password = data.aws_ecr_authorization_token.token-usw1.password
  }
}