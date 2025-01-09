resource "aws_lambda_function" "gd_lambda" {
  filename      = "../src/gd_notifications.zip"
  function_name = "gd_notifications"
  role          = aws_iam_role.lambda_role.arn
  handler       = "gd_notifications.lambda_handler"
  runtime       = "python3.13"

  environment {
    variables = {
      NBA_API_KEY   = var.NBA_API_KEY
      SNS_TOPIC_ARN = aws_sns_topic.sns-topic.arn
    }
  }
}

