# Infrastructure as Code with Terraform

## 1. Overview

This project sets up a scalable and secure infrastructure on AWS using Terraform. The goal is to automate the deployment of key AWS services, including API Gateway, Lambda, CloudWatch, and S3, ensuring a robust CI/CD pipeline via GitHub Actions.

## 2. Prerequisites

### Software Requirements
- Terraform v1.x.x: Infrastructure as Code tool.
- AWS CLI: To manage AWS services from the command line.
- Git: Version control system.

### AWS Account
Ensure you have an AWS account with the necessary permissions to create IAM roles, API Gateway, Lambda functions, and other resources.

## 3. Architecture Diagram

![Project Architecture](docs/assets/architecture.png)

## 4. Project Structure

- `modules/api_gateway`: Contains the API Gateway configuration.
- `modules/cloudwatch`: Contains the CloudWatch alarm configuration.
- `modules/iam_role`: Contains the IAM role configuration.
- `modules/lambda`: Contains the Lambda function configuration.
- `modules/s3_bucket`: Contains the bucket for Lambda code.
- `modules/sns`: Contains the SNS subscription to inform user when alarm arises.
- `.github/workflows/terraform.yml`: Contains GitHub Actions workflows for CI/CD.

## 5. Setup Instructions

   ```bash
   git clone https://github.com/your-repo/infrastructure.git
   cd infrastructure
   ```

## Configuring Terraform
Ensure Terraform is installed and properly configured.

### AWS Credentials
Set up your AWS credentials:

   ```bash
   aws configure
   ```

### Initialize Terraform

   ```bash
   terraform init
   ```

### Deploy Infrastructure

   ```bash
   terraform apply
   ```

Follow the prompts to confirm and deploy the infrastructure.

## 6. Module Documentation

For detailed documentation on each module, please refer to the following files:

- [CloudWatch Module](docs/cloudwatch.md)
- [SNS Module](docs/sns.md)
- [API Gateway Module](docs/api_gateway.md)
- [Lambda Module](docs/lambda.md)
- [IAM Role Module](docs/iam_role.md)
- [S3 Bucket Module](docs/s3_bucket.md)

## 7. CI/CD Pipeline
GitHub Actions Workflow
The provided GitHub Actions workflow automates the Terraform deployment process, ensuring that any changes to the infrastructure are automatically applied.

## 8. Best Practices
Infrastructure as Code (IaC)
This project adheres to IaC principles, allowing for version-controlled and consistent infrastructure deployments.

Security Considerations
IAM roles are configured with the principle of least privilege to minimize security risks.

## 9. Troubleshooting
Common Issues
Terraform Init Errors: Ensure your Terraform version matches the required version.
AWS Permission Denied: Verify that your AWS credentials have the necessary permissions.
Logging and Monitoring
CloudWatch logs can be accessed through the AWS console to debug and monitor the deployed services.

## 10. Conclusion
This project automates the deployment of a scalable and secure infrastructure on AWS. Future enhancements could include more sophisticated monitoring, integration with additional AWS services, and more robust CI/CD features.

## 11. Appendix
References
Terraform Documentation
AWS CLI Documentation

## 12. Changelog
See the CHANGELOG.md file for detailed updates.