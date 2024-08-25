# API Gateway Module Documentation

## Overview

The API Gateway module configures an API Gateway in AWS, serving as the entry point for handling RESTful API requests. It processes incoming requests from users and routes them to the backend, typically an AWS Lambda function, which then generates and returns responses. In this particular implementation, the API responses are limited to a predefined set of HTTP status codes: 200, 300, 400, 500, 501, 503, and 507.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the resources needed to create the API Gateway.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs that are exposed by the module.

## Requirements

1. **API Exposure**: The API must be exposed through an API Gateway. This ensures that incoming requests are managed and routed properly.

2. **API Key Authentication**: The API Gateway should require an API key for authentication. This adds a layer of security by controlling access to the API.

3. **Request Rate**: The setup should handle a maximum of 180 GET requests per 60 seconds. This rate limit ensures that the API can manage high traffic without performance degradation.

## Resources Created

### Define the API Gateway
**Purpose:** Creates the API Gateway to expose the RESTful API.
```hcl
resource "aws_api_gateway_rest_api" "this" {
  name          = "${var.api_name}-${var.stage_name}"
  description   = "API Gateway for ${var.api_name}-${var.stage_name}"

  tags = {
    Name        = "${var.api_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}
```

### Define the Method with API Key Requirement
**Purpose:** Configures the GET method for the statuscode resource and enforces API key authentication.
```hcl
resource "aws_api_gateway_method" "get_statuscode" {
  rest_api_id      = aws_api_gateway_rest_api.this.id
  resource_id      = aws_api_gateway_resource.statuscode.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true
}
```

### Define the Usage Plan with Throttling
**Purpose:** Configures a usage plan to manage API usage and enforce request rate limits, handling up to 180 GET requests per 60 seconds.
```hcl
resource "aws_api_gateway_usage_plan" "status_code_usage_plan" {
  name        = var.api_gateway_usage_plan_name
  description = var.api_gateway_usage_plan_description

  api_stages {
    api_id = aws_api_gateway_rest_api.this.id
    stage  = aws_api_gateway_stage.this.stage_name
  }
  
  throttle_settings {
    burst_limit = var.throttle_burst_limit
    rate_limit  = var.throttle_rate_limit
  }
}
```

This module creates the following AWS resources:
- **API Gateway Rest API**: The primary API Gateway resource that serves as the container for all the other resources.
- **API Gateway Resource**: Represents a resource within the API (e.g., `/statuscode`).
- **API Gateway Method**: Defines the HTTP method (e.g., GET, POST) for a specific resource.
- **API Gateway Integration**: Configures how the method integrates with the backend service (e.g., a Lambda function).
- **API Gateway Deployment**: Deploys the API Gateway to a specified stage (e.g., `dev`, `prod`).
- **API Gateway Stage**: Represents a version of the API that is available for developers to invoke.

## Inputs

The module requires the following input variables:

| Variable Name                        | Type   | Description                                                                                   | Default |
|--------------------------------------|--------|-----------------------------------------------------------------------------------------------|---------|
| `api_name`                           | string | The name of the API Gateway.                                                                  | n/a     |
| `lambda_function_arn`                | string | The ARN of the Lambda function to integrate with the API Gateway.                            | n/a     |
| `api_key_name`                       | string | The name of the API key for securing the API.                                                | n/a     |
| `api_key_description`                | string | Description of the API key to provide context for its use.                                    | n/a     |
| `api_gateway_usage_plan_name`        | string | The name of the API Gateway usage plan to manage API usage and quotas.                        | n/a     |
| `api_gateway_usage_plan_description` | string | Description of the API Gateway usage plan, detailing its purpose and configuration.          | n/a     |
| `throttle_burst_limit`               | number | Maximum number of requests allowed in a short burst.                                          | n/a     |
| `throttle_rate_limit`                | number | Average number of requests allowed per second.                                                | n/a     |
| `stage_name`                         | string | Name of the deployment stage for the API (e.g., dev, prod).                                   | n/a     |
| `region`                             | string | AWS region where the API Gateway and other resources are deployed.                            | n/a     |
| `cloudwatch_log_group_arn`           | string | ARN of the CloudWatch Log Group for API Gateway logs.                                         | n/a     |
| `api_gateway_role_arn`               | string | ARN of the IAM role for API Gateway.                                                           | n/a     |

## Outputs

The module provides the following outputs:

| Output Name           | Description                                           | Value                                                  |
|-----------------------|-------------------------------------------------------|--------------------------------------------------------|
| `invoke_url`          | The base URL of the deployed API Gateway.            | `https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.this.stage_name}` |
| `api_key`             | The API key for accessing the API Gateway.            | `aws_api_gateway_api_key.this.value`                   |
| `rest_api_id`         | The ID of the API Gateway.                           | `aws_api_gateway_rest_api.this.id`                    |
| `deployment_id`       | The ID of the API Gateway deployment.                | `aws_api_gateway_deployment.this.id`                  |
| `execution_arn`       | The ARN execution path of the API Gateway.           | `aws_api_gateway_rest_api.this.execution_arn`         |
| `http_method`         | HTTP method for the Lambda integration.              | `aws_api_gateway_method.get_statuscode.http_method`    |
| `resource_path_part`  | The path part for the API Gateway resource.          | `aws_api_gateway_resource.statuscode.path_part`       |
| `api_id`              | The ID of the API Gateway.                           | `aws_api_gateway_rest_api.this.id`                    |
| `api_name`            | The name of the API Gateway.                         | `aws_api_gateway_rest_api.this.name`                  |
