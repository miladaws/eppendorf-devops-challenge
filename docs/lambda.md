# Lambda Module Documentation

## Overview

The Lambda module provisions an AWS Lambda function. This function is configured with a handler, runtime, and an IAM role. The source code for the Lambda function is assumed to be packaged in a ZIP file and stored in a specific location. The Lambda function is tagged with the environment stage name to facilitate management and tracking.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the AWS Lambda function resource.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs exposed by the module.

## Requirements

1. **Lambda Function Configuration**: Creates an AWS Lambda function with a specified name, handler, runtime, and IAM role. The function code is expected to be packaged in a ZIP file.

2. **IAM Role**: An IAM role with appropriate permissions must be provided to the Lambda function for execution.

## Resources Created

### Define Lambda Function
**Purpose:** Creates an AWS Lambda function with specified configuration, including handler, runtime, and IAM role. The source code is assumed to be a ZIP file.
```hcl
resource "aws_lambda_function" "this" {
  function_name    = "${var.function_name}-${var.stage_name}"
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role_arn

  filename         = "modules/lambda/lambda_function_payload.zip"
  source_code_hash = filebase64sha256("modules/lambda/lambda_function_payload.zip")

  environment {
    variables = {
      STAGE = var.stage_name
    }
  }

  tags = {
    Name        = "${var.function_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}
```

## Input Variables

The module requires the following input variables:

| Variable Name                | Type   | Description                                              | Default |
|------------------------------|--------|----------------------------------------------------------|---------|
| `function_name`              | string | The name of the Lambda function.                        | n/a     |
| `handler`                    | string | The handler for the Lambda function.                     | n/a     |
| `runtime`                    | string | The runtime environment for the Lambda function.         | n/a     |
| `role_arn`                   | string | The ARN of the IAM role for the Lambda function.         | n/a     |
| `source_code_bucket`         | string | The S3 bucket where the Lambda source code is stored.    | n/a     |
| `source_code_key`            | string | The S3 object key for the Lambda source code.            | n/a     |
| `stage_name`                 | string | The environment stage name (e.g., dev, prod).            | n/a     |
| `api_gateway_arn`            | string | The ARN of the API Gateway invoking the Lambda function. | n/a     |
| `http_method`                | string | HTTP method for the API Gateway to invoke Lambda.        | n/a     |
| `api_gateway_resource_path_part` | string | The path part for the API Gateway resource.           | n/a     |


## Outputs

The module provides the following outputs:

| Output Name     | Description                                       | Value                             |
|-----------------|---------------------------------------------------|-----------------------------------|
| `function_arn`  | The ARN of the Lambda function.                  | `aws_lambda_function.this.arn`    |
| `function_name` | The name of the Lambda function.                 | `aws_lambda_function.this.function_name` |
