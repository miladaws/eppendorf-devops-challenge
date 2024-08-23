output "invoke_url" {
  description = "The base URL of the deployed API Gateway"
  value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.this.stage_name}"
}

output "api_key" {
  description = "The API key for accessing the API Gateway"
  value       = aws_api_gateway_api_key.this.value
}

output "rest_api_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}

output "deployment_id" {
  description = "The ID of the API Gateway deployment"
  value       = aws_api_gateway_deployment.this.id
}


output "execution_arn" {
  description = "The ARN execution path of the API Gateway"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "http_method" {
  description = "HTTP method for the Lambda integration"
  value       = aws_api_gateway_method.get_statuscode.http_method
}

output "resource_path_part" {
  description = "The path part for the API Gateway resource"
  value       = aws_api_gateway_resource.statuscode.path_part
}

output "api_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "api_name" {
  value = aws_api_gateway_rest_api.this.name
}