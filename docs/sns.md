# SNS Module Documentation

## Overview

The SNS module provisions an AWS SNS (Simple Notification Service) topic and sets up a subscription for that topic. The subscription is configured with a specified protocol and endpoint, allowing notifications to be sent to the desired endpoint.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the AWS SNS topic and SNS topic subscription.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs exposed by the module.

## Requirements

1. **SNS Topic**: An SNS topic is created with a specified name.
2. **SNS Subscription**: A subscription is created for the SNS topic, specifying a protocol and an endpoint.

## Resources Created

### Define SNS Topic
**Purpose:** Creates an SNS topic with the specified name.
```hcl
resource "aws_sns_topic" "this" {
  name = var.topic_name
}
```

## Define SNS Subscription

**Purpose:** Creates a subscription to the SNS topic with the specified protocol and endpoint.
```hcl
resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.protocol
  endpoint  = var.endpoint
}
```

## Inputs

The module requires the following input variables:

| Variable Name | Type   | Description                                   | Default |
|---------------|--------|-----------------------------------------------|---------|
| `topic_name`  | string | The name of the SNS topic.                    | n/a     |
| `protocol`    | string | The protocol to use for the subscription (e.g., email, sms). | n/a     |
| `endpoint`    | string | The endpoint for the subscription (e.g., email address). | n/a     |


## Outputs

The module provides the following outputs:

| Output Name | Description                  | Value                          |
|-------------|------------------------------|--------------------------------|
| `topic_arn` | The ARN of the SNS topic.    | `aws_sns_topic.this.arn`       |

