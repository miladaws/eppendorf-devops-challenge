variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "eu-central-1"
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
}

variable "terraform_state_lock_table" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role for the Lambda function."
  type        = string
  default     = "lambda_execution_role"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "status_codes_lambda"
}

variable "lambda_handler" {
  description = "The handler function in the Lambda."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function."
  type        = string
  default     = "python3.9"
}

variable "source_code_bucket" {
  description = "The S3 bucket name where the Lambda source code is stored."
  type        = string
}

variable "source_code_key" {
  description = "The S3 object key for the Lambda source code."
  type        = string
}

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

variable "stage_name" {
  description = "The name of the API Gateway stage."
  type        = string
  default     = "dev"
}

variable "alarm_name" {
  description = "CloudWatch alarm name."
  type        = string
  default     = "5xx_errors_alarm"
}

variable "alarm_metric_name" {
  description = "The metric name of alarm."
  type        = string
}

variable "alarm_namespace" {
  description = "The namespace of alarm."
  type        = string
}

variable "sns_endpoint" {
  description = "The email address for SNS notifications."
  type        = string
}

