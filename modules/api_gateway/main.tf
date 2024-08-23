# Define the API Gateway
resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.api_name}-${var.stage_name}"
  description = "API Gateway for ${var.api_name}-${var.stage_name}"

  tags = {
    Name        = "${var.api_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}

# Define the resource
resource "aws_api_gateway_resource" "statuscode" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "statuscode"
}

# Define the method
resource "aws_api_gateway_method" "get_statuscode" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.statuscode.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

# Define the deployment
resource "aws_api_gateway_deployment" "this" {
  depends_on  = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.statuscode.id,
      aws_api_gateway_method.get_statuscode.id,
      aws_api_gateway_integration.lambda.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Define the stage
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
  description   = "Stage for ${var.stage_name}"

  depends_on = [aws_api_gateway_account.this]
}

# Define method settings
resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }

  depends_on = [aws_api_gateway_account.this]
}



# Define the API Key
resource "aws_api_gateway_api_key" "this" {
  name        = "${var.api_name}-api-key"
  description = var.api_key_description
  enabled     = true
}

# Define the Usage Plan
resource "aws_api_gateway_usage_plan" "status_code_usage_plan" {
  name        = var.api_gateway_usage_plan_name
  description = var.api_gateway_usage_plan_description

  api_stages {
    api_id = aws_api_gateway_rest_api.this.id
    stage  = aws_api_gateway_stage.this.stage_name
  }
  
  throttle_settings {
    burst_limit = var.throttle_burst_limit
    rate_limit  = var.throttle_rate_limit
  }
}

# Define the Usage Plan Key
resource "aws_api_gateway_usage_plan_key" "status_code_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.this.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.status_code_usage_plan.id
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.statuscode.id
  http_method             = aws_api_gateway_method.get_statuscode.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

resource "aws_iam_role" "cloudwatch" {
  name = "api_gateway_cloudwatch_global"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "default"
  role = aws_iam_role.cloudwatch.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}
