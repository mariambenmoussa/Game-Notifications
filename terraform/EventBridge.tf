resource "aws_scheduler_schedule" "scheduler" {
  name       = "gd-schedule"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(5 minutes)"

  target {
    arn      = aws_lambda_function.gd_lambda.arn
    role_arn = aws_iam_role.eventbridge_role.arn
  }
}
