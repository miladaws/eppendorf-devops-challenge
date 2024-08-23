provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

# S3 Bucket Module
module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.source_code_bucket
  stage_name  = var.stage_name
}

# IAM Role Module
module "iam_role" {
  source      = "./modules/iam_role"
  role_name   = var.role_name
  stage_name  = var.stage_name
}

# Lambda Function Module
module "lambda" {
  source                         = "./modules/lambda"
  function_name                  = var.lambda_function_name
  handler                        = var.lambda_handler
  runtime                        = var.lambda_runtime
  role_arn                       = module.iam_role.role_arn
  source_code_bucket             = module.s3_bucket.bucket_arn
  source_code_key                = var.source_code_key
  stage_name                     = var.stage_name
  api_gateway_arn                = module.api_gateway.execution_arn
  http_method                    = module.api_gateway.http_method
  api_gateway_resource_path_part = module.api_gateway.resource_path_part
}

# API Gateway Module
module "api_gateway" {
  source                             = "./modules/api_gateway"
  api_name                           = var.api_name
  api_key_name                       = var.api_key_name
  api_key_description                = var.api_key_description
  api_gateway_usage_plan_name        = var.api_gateway_usage_plan_name
  api_gateway_usage_plan_description = var.api_gateway_usage_plan_description
  throttle_burst_limit               = 200
  throttle_rate_limit                = 180
  lambda_function_arn                = module.lambda.function_arn
  stage_name                         = var.stage_name
  region                             = var.aws_region
}

# SNS Module
module "sns" {
  source      = "./modules/sns"
  topic_name  = "api-gateway-alarms"
  protocol    = "email"  # or "sms", "lambda", etc.
  endpoint    = "rezaeimilad@gmail.com"  # Replace with your email or endpoint
}

# CloudWatch Alarm Module
module "cloudwatch" {
  source        = "./modules/cloudwatch"
  alarm_name    = "High5xxErrors"
  metric_name   = "5xxErrors"
  namespace     = "API/Errors"
  threshold     = 10
  evaluation_periods = 1
  api_name      = module.api_gateway.api_name
  stage_name    = var.stage_name
  alarm_actions        = [module.sns.topic_arn]
}

# Ensure the CloudWatch Log Group exists
resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name = "/aws/apigateway/${var.api_name}-${var.stage_name}"
}

# CloudWatch Metric Filter
resource "aws_cloudwatch_log_metric_filter" "api_gateway_5xx_errors" {
  name           = "5xxErrorsFilter"
  log_group_name = aws_cloudwatch_log_group.api_gateway_log_group.name
  pattern        = "{ $.status = 5* }"

  metric_transformation {
    name      = "5xxErrors"
    namespace = "Eppendorf/ApiGateway"
    value     = "1"
  }
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${module.api_gateway.api_id}/*/GET/statuscode"
}
