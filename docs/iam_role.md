# IAM Role Module Documentation

## Overview

The IAM Role module configures IAM roles required for Lambda function execution and API Gateway access. It includes policies for basic Lambda execution, CloudWatch logs, and X-Ray write access. This setup ensures that the Lambda function has the necessary permissions to run and interact with AWS services and that the API Gateway can log to CloudWatch.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the IAM roles and policy attachments.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs exposed by the module.

## Input Variables

The module requires the following input variables:

| Variable Name | Type   | Description                                          | Default |
|---------------|--------|------------------------------------------------------|---------|
| `role_name`   | string | The name of the IAM role for the Lambda function.   | n/a     |
| `stage_name`  | string | The environment stage name (e.g., dev, prod).       | n/a     |


## Outputs

The module provides the following outputs:

| Output Name         | Description                                      | Value                                       |
|---------------------|--------------------------------------------------|---------------------------------------------|
| `role_arn`          | The ARN of the IAM role created for the Lambda function. | `aws_iam_role.lambda_execution_role.arn`  |
| `api_gateway_role_arn` | The ARN of the IAM role created for API Gateway. | `aws_iam_role.api_gateway_role.arn`        |

