variable "api_name" {
  description = "The name of the API Gateway."
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to integrate with the API Gateway."
  type        = string
}

variable "api_key_name" {
  description = "The name of the API key."
  type        = string
}

variable "api_key_description" {
  description = "The name of the API key description."
  type        = string
}

variable "api_gateway_usage_plan_name" {
  description = "The name of the API Gateway usage plan."
  type        = string
}

variable "api_gateway_usage_plan_description" {
  description = "The description of the API Gateway usage plan."
  type        = string
}

variable "throttle_burst_limit" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
}

variable "throttle_rate_limit" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
}

variable "stage_name" {
  description = "The environment stage name (e.g., dev, prod)."
  type        = string
}

variable "region" {
  description = "The AWS region where the resources are deployed."
  type        = string
}

variable "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for API Gateway logs"
  type        = string
}

variable "api_gateway_role_arn" {
  description = "The ARN of the IAM role for API Gateway"
  type        = string
}