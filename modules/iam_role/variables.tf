
variable "role_name" {
  description = "The name of the IAM role for the Lambda function."
  type        = string
}

variable "stage_name" {
  description = "The environment stage name (e.g., dev, prod)."
  type        = string
}