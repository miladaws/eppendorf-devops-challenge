# CloudWatch Module Documentation

## Overview

The CloudWatch module creates a CloudWatch alarm to monitor specific metrics related to API Gateway performance. This alarm triggers when the specified metric exceeds a defined threshold, allowing for proactive monitoring and alerting based on API Gateway errors. In this implementation, the alarm is configured to monitor `5XXError` metrics, indicating server-side errors in the API Gateway.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the CloudWatch alarm resource and its configuration.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs that are exposed by the module.

## Requirements

1. **Metric Monitoring**: The alarm must monitor the `5XXError` metric for the API Gateway to track server-side errors.

2. **Threshold Configuration**: The alarm is triggered when the number of errors exceeds the specified threshold, which is set to 10 in this configuration. When errors go beyond the threshold then the user will be notified. Check out [SNS Module](sns.md)

3. **Evaluation Periods**: The alarm evaluates data over a defined number of periods (default is 1), ensuring timely detection of issues.

## Resources Created

### Define the CloudWatch Metric Alarm
**Purpose:** Creates a CloudWatch alarm to monitor API Gateway errors and trigger actions if the threshold is exceeded.
```hcl
resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_name}-${var.stage_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "5XXError"
  namespace           = "Eppendorf/ApiGateway"
  period              = 10  
  statistic           = "Sum"
  threshold           = var.threshold
  alarm_description   = "Alarm for more than 10 5XX errors in API Gateway within 10 seconds"
  actions_enabled     = true

  dimensions = {
    ApiName   = var.api_name
    Stage     = var.stage_name
  }

  alarm_actions = var.alarm_actions 

  tags = {
    Name        = "${var.alarm_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}
```

## Input Variables

The module requires the following input variables:

| Variable Name        | Type        | Description                                                              | Default |
|----------------------|-------------|--------------------------------------------------------------------------|---------|
| `alarm_name`         | string      | The name of the CloudWatch alarm.                                        | n/a     |
| `metric_name`        | string      | The name of the metric to monitor. For 5xx errors.                       | n/a     |
| `namespace`          | string      | The namespace of the CloudWatch metric.                                  | n/a     |
| `threshold`          | number      | The threshold for triggering the alarm. Set to 10 for more than 10 errors.| n/a     |
| `evaluation_periods` | number      | Number of periods over which data is compared to the specified threshold.| `1`     |
| `api_name`           | string      | The name of the API Gateway.                                              | n/a     |
| `stage_name`         | string      | The environment stage name (e.g., dev, prod).                            | n/a     |
| `alarm_actions`      | list(string)| List of ARNs for actions to execute when the alarm is triggered.          | n/a     |



## Outputs

The module provides the following outputs:

| Output Name | Description                                      | Value                                      |
|-------------|--------------------------------------------------|--------------------------------------------|
| `alarm_id`  | The ID of the CloudWatch alarm.                  | `aws_cloudwatch_metric_alarm.this.id`      |
| `alarm_arn` | The ARN of the CloudWatch alarm.                 | `aws_cloudwatch_metric_alarm.this.arn`     |
