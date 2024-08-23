# API Gateway Module Documentation

## Overview

The API Gateway module is responsible for setting up an API Gateway in AWS. This service acts as the front door for applications to access data, business logic, or functionality from backend services such as AWS Lambda. The API Gateway allows you to create, publish, maintain, monitor, and secure APIs at any scale.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the resources needed to create the API Gateway.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs that are exposed by the module.

## Resources Created

This module creates the following AWS resources:
- **API Gateway Rest API**: The primary API Gateway resource that serves as the container for all the other resources.
- **API Gateway Resource**: Represents a resource within the API (e.g., `/users`, `/posts`).
- **API Gateway Method**: Defines the HTTP method (e.g., GET, POST) for a specific resource.
- **API Gateway Integration**: Configures how the method integrates with the backend service (e.g., a Lambda function).
- **API Gateway Deployment**: Deploys the API Gateway to a specified stage (e.g., `dev`, `prod`).
- **API Gateway Stage**: Represents a version of the API that is available for developers to invoke.

## Input Variables

The module requires the following input variables:

| Variable Name           | Type   | Description                                           | Default         |
|-------------------------|--------|-------------------------------------------------------|-----------------|
| `api_name`              | string | Name of the API Gateway                               | `"my-api"`      |
| `stage_name`            | string | The deployment stage for the API                      | `"dev"`         |
| `lambda_function_arn`   | string | ARN of the Lambda function to integrate with the API  | n/a             |
| `enable_cors`           | bool   | Whether to enable CORS for the API                    | `true`          |

## Outputs

This module provides the following outputs:

| Output Name             | Description                                           |
|-------------------------|-------------------------------------------------------|
| `api_gateway_id`        | The ID of the created API Gateway                     |
| `api_gateway_url`       | The URL endpoint of the deployed API                  |

