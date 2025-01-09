#Create a role/policy  for Lambda function to be able to publish to SNS 

resource "aws_iam_policy" "sns-policy" {
  name        = "SNS_policy"
  path        = "/"
  description = "SNS policy for Lambda function"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:Publish",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sns:us-east-1:${var.awsaccountid}:gd-topic"
      },
    ]
  })
}

resource "aws_iam_role" "lambda_role" {
  name = "Lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name = "Lambda_role_policy"
  role = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction",
          "lambda:InvokeAsync"
        ],
        "Resource" : "*"
      }
    ]
  })
}

data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn
}

resource "aws_iam_role_policy_attachment" "snspolicy-attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.sns-policy.arn
}

resource "aws_iam_role" "eventbridge_role" {
  name = "Eventbridge_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      },
    ]
  })
}