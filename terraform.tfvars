# AWS Region
aws_region = "eu-central-1"

# IAM Role Name
role_name = "lambda_execution_role"

# Lambda Function Name
lambda_function_name = "status_codes_lambda"

# Lambda Function Handler
lambda_handler = "lambda_function.lambda_handler"

# Lambda Function Runtime
lambda_runtime = "python3.9"

# S3 Bucket for Lambda Source Code
source_code_bucket = "eppendorf-lambda-source-bucket082024"

# S3 Object Key for Lambda Source Code
source_code_key = "modules/lambda/lambda_function_payload.zip"

# API Gateway Name
api_name = "status_codes_api"

# API Gateway Stage Name
stage_name = "prod"

# CloudWatch Alarm Name
alarm_name = "5xx_errors_alarm"