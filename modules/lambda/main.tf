resource "aws_lambda_function" "this" {
  function_name    = "${var.function_name}-${var.stage_name}"
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role_arn

  filename         = "modules/lambda/lambda_function_payload.zip"
  source_code_hash = filebase64sha256("modules/lambda/lambda_function_payload.zip")

  environment {
    variables = {
      STAGE = var.stage_name
    }
  }

  tags = {
    Name        = "${var.function_name}-${var.stage_name}"
    Environment = var.stage_name
  }
}