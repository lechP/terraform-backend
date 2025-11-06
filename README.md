# General

This repository contains terraform configuration of the necessary resources to create AWS-based terraform backend.
Mainly it creates S3 bucket and DynamoDB table for state locking.

# Usage

Prerequisites:
- AWS credentials (one of options is `.aws/credentials` file) configured with appropriate permissions to create S3 bucket and DynamoDB tables
- Terraform installed (version 0.12 or higher)

Just run the following commands to initialize and apply the terraform configuration:
```shell
terraform init
terraform apply
```

You can also override default values of the variables via `-var` flag or `terraform.tfvars` file.