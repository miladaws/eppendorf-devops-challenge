variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The handler for the Lambda function."
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function."
  type        = string
}

variable "source_code_bucket" {
  description = "The S3 bucket where the Lambda source code is stored."
  type        = string
}

variable "source_code_key" {
  description = "The S3 object key for the Lambda source code."
  type        = string
}

variable "stage_name" {
  description = "The environment stage name (e.g., dev, prod)."
  type        = string
}

variable "api_gateway_arn" {
  description = "The ARN of the API Gateway invoking the Lambda function"
  type        = string
}

variable "http_method" {
  description = "HTTP method for the API Gateway to invoke Lambda"
  type        = string
}

variable "api_gateway_resource_path_part" {
  description = "The path part for the API Gateway resource"
  type        = string
}