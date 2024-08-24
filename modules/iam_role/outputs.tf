output "role_arn" {
  description = "The ARN of the IAM role created for the Lambda function."
  value       = aws_iam_role.lambda_execution_role.arn
}

output "api_gateway_role_arn" {
  description = "The ARN of the IAM role created for API Gateway"
  value       = aws_iam_role.api_gateway_role.arn
}