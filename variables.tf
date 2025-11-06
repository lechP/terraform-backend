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

