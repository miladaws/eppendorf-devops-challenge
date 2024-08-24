output "api_gateway_url" {
  description = "The base URL of the deployed API Gateway"
  value       = module.api_gateway.invoke_url
}

output "api_key" {
  description = "The API key for accessing the API Gateway"
  value       = module.api_gateway.api_key
  sensitive = true
}

output "lambda_function_arn" {
  description = "The ARN of the deployed Lambda function"
  value       = module.lambda.function_arn
}

output "cloudwatch_alarm_id" {
  description = "The ID of the CloudWatch alarm for monitoring 5XX errors"
  value       = module.cloudwatch.alarm_id
}
