# General

This repository contains terraform configuration of the necessary resources to create AWS-based terraform backend plus definition of GitHub based CI access.
It does create:
* S3 bucket and DynamoDB table for state locking
* GitHub Actions OIDC provider 
* Policy for accessing the S3 bucket and DynamoDB table
* Policies for deploying other resources (EC2, RDS, S3, Lambda, etc.)
* GitHub repository level OIDC role with the above policies attached

# Usage

Prerequisites:
- AWS credentials (one of options is `.aws/credentials` file) configured with appropriate permissions to create S3 bucket and DynamoDB tables
- Terraform installed (version 0.12 or higher)

Just run the following commands to initialize and apply the terraform configuration:
```shell
terraform init
terraform apply \
  -var github_org="GITHUB_ORG_OR_USER" \
  -var github_repo="GITHUB_REPO" \
  -var allow_branches='["refs/heads/main"]'
```

You can also override default values of the variables via `-var` flag or `terraform.tfvars` file.