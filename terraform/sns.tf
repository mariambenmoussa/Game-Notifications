resource "aws_sns_topic" "sns-topic" {
  name = "gd-topic"
}


resource "aws_sns_topic_subscription" "sns-topic-subscription" {
  topic_arn = aws_sns_topic.sns-topic.arn
  protocol  = "email"
  endpoint  = var.myemail
}
