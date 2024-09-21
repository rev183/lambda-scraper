module lambda_proxy_aps1 {
  source          = "./module"
  providers       = { 
    aws = aws
  }
  num_proxies     = var.num_proxies
  region          = "ap-south-1"
  lambda_role_arn = aws_iam_role.lambda_execution_role.arn
}

module lambda_proxy_apse1 {
  source      = "./module"
  providers       = { 
    aws    = aws.apse1
    docker = docker.apse1
  }
  num_proxies     = var.num_proxies
  region          = "ap-southeast-1"
  lambda_role_arn = aws_iam_role.lambda_execution_role.arn
}

module lambda_proxy_usw1 {
  source      = "./module"
  providers       = { 
    aws    = aws.usw1
    docker = docker.usw1
  }
  num_proxies     = var.num_proxies
  region          = "us-west-1"
  lambda_role_arn = aws_iam_role.lambda_execution_role.arn
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
      ],
      Resource = [
          "arn:aws:logs:*:569157651643:log-group:/aws/lambda/proxy-*:*:*",
          "arn:aws:logs:*:569157651643:log-group:/aws/lambda/proxy-*:*"
     ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
