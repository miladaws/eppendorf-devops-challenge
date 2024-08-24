variable "terraform_state_bucket" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
}

variable "terraform_state_lock_table" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the resources will be created"
  type        = string
}