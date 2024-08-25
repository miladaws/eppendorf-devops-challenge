# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2024-08-25

### Added
- API Gateway module for creating and managing API Gateway resources, methods, and integrations.
- CloudWatch module for setting up alarms based on metrics.
- IAM Role module for provisioning roles and policies for Lambda and API Gateway.
- Lambda module for deploying Lambda functions with specified configurations.
- SNS module for creating SNS topics and subscriptions.
- S3 Bucket module for managing S3 buckets and versioning.

### Changed
- Updated Lambda module to support deployment from S3 bucket.
- Refined IAM Role module to include X-Ray and CloudWatch policies.
- Improved API Gateway module with additional configurations for usage plans and API keys.

### Fixed
- Corrected S3 bucket configuration to include versioning.
- Resolved issue with API Gateway stage logging settings.


