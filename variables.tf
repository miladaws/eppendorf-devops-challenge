# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "eu-central-1"
}

# IAM Role Name
variable "role_name" {
  description = "The name of the IAM role for the Lambda function."
  type        = string
  default     = "lambda_execution_role"
}

# Lambda Function Name
variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "status_codes_lambda"
}

# Lambda Function Handler
variable "lambda_handler" {
  description = "The handler function in the Lambda."
  type        = string
  default     = "lambda_function.lambda_handler"
}

# Lambda Function Runtime
variable "lambda_runtime" {
  description = "The runtime for the Lambda function."
  type        = string
  default     = "python3.9"
}

# S3 Bucket for Lambda Source Code
variable "source_code_bucket" {
  description = "The S3 bucket name where the Lambda source code is stored."
  type        = string
}

# S3 Object Key for Lambda Source Code
variable "source_code_key" {
  description = "The S3 object key for the Lambda source code."
  type        = string
}

# API Gateway Name
variable "api_name" {
  description = "The name of the API Gateway."
  type        = string
  default     = "status_codes_api"
}

variable "api_key_name" {
  description = "The name of the API key."
  type        = string
  default     = "status_code_api_key"
}

variable "api_key_description" {
  description = "The description of the API key."
  type        = string
  default     = "API key for status code API"
}

variable "api_gateway_usage_plan_name" {
  description = "The name of the API Gateway usage plan."
  type        = string
  default     = "status_code_usage_plan_name"
}

variable "api_gateway_usage_plan_description" {
  description = "The description of the API Gateway usage plan."
  type        = string
  default     = "status_code_usage_plan_description"
}

# API Gateway Stage Name
variable "stage_name" {
  description = "The name of the API Gateway stage."
  type        = string
  default     = "dev"
}

# CloudWatch Alarm Name
variable "alarm_name" {
  description = "The name of the CloudWatch alarm."
  type        = string
  default     = "5xx_errors_alarm"
}
