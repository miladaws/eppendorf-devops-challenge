resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_name}-${var.stage_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = 10  
  statistic           = "Sum"
  threshold           = var.threshold
  alarm_description   = "Alarm for more than 10 5XX errors in API Gateway within 10 seconds"
  actions_enabled     = true

  dimensions = {
    ApiName   = var.api_name
    Stage = var.stage_name
  }

  alarm_actions = var.alarm_actions 

  tags = {
    Name        = "${var.alarm_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}