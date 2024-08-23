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
  name        = "${var.api_name}-${var.stage_name}"
  description = "API Gateway for ${var.api_name}-${var.stage_name}"

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
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.statuscode.id
  http_method   = "GET"
  authorization = "NONE"
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

## Usage


## Input Variables

The module requires the following input variables:

| Variable Name                      | Type   | Description                                                                                 | Default         |
|------------------------------------|--------|---------------------------------------------------------------------------------------------|-----------------|
| `api_name`                         | string | Name of the API Gateway.                                                                    | `"my-api"`      |
| `lambda_function_arn`              | string | ARN of the Lambda function to integrate with the API Gateway.                              | n/a             |
| `api_key_name`                     | string | The name of the API key for securing the API.                                               | n/a             |
| `api_key_description`              | string | Description of the API key to provide context for its use.                                  | n/a             |
| `api_gateway_usage_plan_name`      | string | Name of the API Gateway usage plan to manage API usage and quotas.                           | n/a             |
| `api_gateway_usage_plan_description` | string | Description of the API Gateway usage plan, detailing its purpose and configuration.          | n/a             |
| `throttle_burst_limit`             | number | Maximum number of requests allowed in a short burst, used to control traffic spikes.        | `100`           |
| `throttle_rate_limit`              | number | Average number of requests allowed per second, used to regulate steady traffic.             | `60`            |
| `stage_name`                       | string | Name of the deployment stage for the API (e.g., dev, prod).                                 | `"dev"`         |
| `region`                           | string | AWS region where the API Gateway and other resources are deployed.                          | `"eu-central-1"`   |

## Justifications

- **`api_name`**: Defines the name of the API Gateway, which is essential for identifying and managing the API Gateway.

- **`lambda_function_arn`**: The ARN (Amazon Resource Name) of the Lambda function that will be integrated with the API Gateway. This linkage allows the API Gateway to invoke the Lambda function in response to requests.

- **`api_key_name`**: Specifies the name of the API key used for securing the API. The API key is crucial for access control and usage tracking.

- **`api_key_description`**: Provides a description of the API key, offering context for its purpose and use. This helps in managing and documenting the API key.

- **`api_gateway_usage_plan_name`**: Names the API Gateway usage plan, which helps manage API usage and enforce quotas. This is important for maintaining API performance and security.

- **`api_gateway_usage_plan_description`**: Describes the usage plan, including its purpose and configuration details. This aids in understanding the limits and policies applied to the API Gateway.

- **`throttle_burst_limit`**: Sets the maximum number of requests allowed in a burst, helping to handle sudden spikes in traffic and prevent service overload.

- **`throttle_rate_limit`**: Defines the average number of requests permitted per second, which regulates steady traffic and ensures consistent performance.

- **`stage_name`**: Represents the deployment stage (e.g., development, production) of the API. This allows for environment-specific configurations and management.

- **`region`**: Specifies the AWS region where the API Gateway and other resources are deployed. Proper region selection is crucial for resource availability and latency considerations.

## Outputs

This module provides the following outputs:

## Output Descriptions

| Output Name           | Description                                           | Value                                                  |
|-----------------------|-------------------------------------------------------|--------------------------------------------------------|
| `invoke_url`          | The base URL of the deployed API Gateway.            | `aws_api_gateway_rest_api.this.execution_arn`         |
| `rest_api_id`         | The ID of the API Gateway.                           | `aws_api_gateway_rest_api.this.id`                    |
| `deployment_id`       | The ID of the API Gateway deployment.                | `aws_api_gateway_deployment.this.id`                  |
| `execution_arn`       | The ARN execution path of the API Gateway.           | `aws_api_gateway_rest_api.this.execution_arn`         |
| `http_method`         | HTTP method for the Lambda integration.              | `aws_api_gateway_method.get_statuscode.http_method`    |
| `resource_path_part`  | The path part for the API Gateway resource.          | `aws_api_gateway_resource.statuscode.path_part`       |
| `api_id`              | The ID of the API Gateway.                           | `aws_api_gateway_rest_api.this.id`                    |
| `api_name`            | The name of the API Gateway.                         | `aws_api_gateway_rest_api.this.name`                  |

## Justifications

- **`invoke_url`**: Provides the base URL for the deployed API Gateway, allowing clients to access the API.

- **`rest_api_id`**: Outputs the unique identifier of the API Gateway, which can be used for management and integration purposes.

- **`deployment_id`**: Shows the identifier of the API Gateway deployment, useful for tracking and managing specific deployments.

- **`execution_arn`**: Displays the ARN (Amazon Resource Name) of the API Gateway execution path, which can be used to uniquely identify and reference the API Gateway.

- **`http_method`**: Indicates the HTTP method used for integrating with the Lambda function, which helps in understanding the type of HTTP requests handled.

- **`resource_path_part`**: Provides the path part of the API Gateway resource, which is part of the URL used to access the API.

- **`api_id`**: Outputs the ID of the API Gateway, useful for API management and referencing within AWS.

- **`api_name`**: Shows the name of the API Gateway, aiding in identification and management of the API within AWS.
