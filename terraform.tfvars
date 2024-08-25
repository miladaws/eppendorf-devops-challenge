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

# The email address for SNS notifications.
sns_endpoint = "your-email@example.com"

# The metric name of alarm.
alarm_metric_name = "5XXError"

# The name space of alarm.
alarm_namespace = "Eppendorf/ApiGateway"

# S3 bucket name for state file
terraform_state_bucket      = "eppendorf-s3-state-bucket082024"  # Replace with you bucket name

# DynamoDB table for state locking
terraform_state_lock_table  = "eppendorf-dynamodb-locking-table" # Replace with your DynamoDB table name