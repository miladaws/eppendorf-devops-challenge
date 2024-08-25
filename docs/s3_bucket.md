# S3 Bucket Module Documentation

## Overview

The S3 Bucket module provisions an AWS S3 bucket and enables versioning on the bucket. This setup is typically used for storing Lambda function code or other assets.

## Module Structure

The module contains the following Terraform files:
- **`main.tf`**: Defines the AWS S3 bucket and its versioning configuration.
- **`variables.tf`**: Defines the input variables required by the module.
- **`outputs.tf`**: Defines the outputs exposed by the module.

## Resources Created

### Define S3 Bucket
**Purpose:** Creates an S3 bucket with the specified name.
```hcl
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = "Lambda Source Code Bucket"
    Environment = var.stage_name
  }
}
```

### Define S3 Bucket Versioning
**Purpose:** Enables versioning on the created S3 bucket to keep track of changes.
```hcl
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
```

## Input Variables

The module requires the following input variables:

| Variable Name | Type   | Description                  | Default |
|---------------|--------|------------------------------|---------|
| `bucket_name` | string | Name of the S3 bucket.       | n/a     |
| `stage_name`  | string | Deployment stage name.       | n/a     |

## Outputs

The module provides the following outputs:

| Output Name | Description                      | Value                       |
|-------------|----------------------------------|-----------------------------|
| `bucket_id` | The ID of the S3 bucket.         | `aws_s3_bucket.this.id`     |
| `bucket_arn`| The ARN of the S3 bucket.        | `aws_s3_bucket.this.arn`    |
