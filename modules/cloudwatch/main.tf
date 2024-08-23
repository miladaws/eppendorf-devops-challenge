resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_name}-${var.stage_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name = "5xxErrors"
namespace   = "Eppendorf/ApiGateway"
  period              = 10  # Period set to 10 seconds
  statistic           = "Sum"
  threshold           = var.threshold
  alarm_description   = "Alarm for more than 10 5XX errors in API Gateway within 10 seconds"
  actions_enabled     = true

  dimensions = {
    ApiName   = var.api_name
    StageName = var.stage_name
  }

  alarm_actions = var.alarm_actions 

  tags = {
    Name        = "${var.alarm_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}