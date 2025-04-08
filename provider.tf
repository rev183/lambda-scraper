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
  region  = "ap-southeast-2"
  alias   = "apse2"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias   = "usw1"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
  alias   = "usw2"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
  alias   = "euc1"
}

provider "aws" {
  profile = "default"
  region  = "eu-north-1"
  alias   = "eun1"
}

data "aws_caller_identity" "this" {}

data "aws_ecr_authorization_token" "token" {
  
}

data "aws_ecr_authorization_token" "token-apse2" {
  provider = aws.apse2
}

data "aws_ecr_authorization_token" "token-apse1" {
  provider = aws.apse1
}

data "aws_ecr_authorization_token" "token-usw1" {
  provider = aws.usw1
}

data "aws_ecr_authorization_token" "token-usw2" {
  provider = aws.usw2
}

data "aws_ecr_authorization_token" "token-euc1" {
  provider = aws.euc1
}

data "aws_ecr_authorization_token" "token-eun1" {
  provider = aws.eun1
}

provider "docker" {
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "ap-south-1")
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}

provider "docker" {
  alias   = "apse1"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "ap-southeast-1")
    username = data.aws_ecr_authorization_token.token-apse1.user_name
    password = data.aws_ecr_authorization_token.token-apse1.password
  }
}

provider "docker" {
  alias   = "apse2"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "ap-southeast-2")
    username = data.aws_ecr_authorization_token.token-apse2.user_name
    password = data.aws_ecr_authorization_token.token-apse2.password
  }
}

provider "docker" {
  alias   = "usw1"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "us-west-1")
    username = data.aws_ecr_authorization_token.token-usw1.user_name
    password = data.aws_ecr_authorization_token.token-usw1.password
  }
}

provider "docker" {
  alias   = "usw2"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "us-west-2")
    username = data.aws_ecr_authorization_token.token-usw2.user_name
    password = data.aws_ecr_authorization_token.token-usw2.password
  }
}

provider "docker" {
  alias   = "euc1"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "eu-central-1")
    username = data.aws_ecr_authorization_token.token-euc1.user_name
    password = data.aws_ecr_authorization_token.token-euc1.password
  }
}

provider "docker" {
  alias   = "eun1"
  host = "unix:///Users/revanth/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, "eu-north-1")
    username = data.aws_ecr_authorization_token.token-eun1.user_name
    password = data.aws_ecr_authorization_token.token-eun1.password
  }
}