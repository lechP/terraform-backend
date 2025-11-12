variable "region" {
  description = "AWS region for the backend resources"
  type        = string
  default     = "eu-west-3"
}

variable "project" {
  description = "Project prefix for naming"
  type        = string
  default     = "lpi"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name. If empty, one will be generated."
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locks"
  type        = string
  default     = "tf-locks"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {
    ManagedBy = "terraform"
    Purpose   = "tf-backend"
  }
}

variable "github_org" {
  description = "GitHub organization or user that owns the repo"
  type        = string
}

variable "github_repo" {
  description = "Repository name that will run GitHub Actions"
  type        = string
}

variable "allow_branches" {
  description = "Which refs are allowed to assume the role (e.g., main only)"
  type        = list(string)
  default     = ["refs/heads/main"]
}

# GitHub OIDC thumbprints
variable "github_oidc_thumbprints" {
  description = "SHA-1 thumbprints for token.actions.githubusercontent.com"
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

