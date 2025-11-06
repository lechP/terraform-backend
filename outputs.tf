output "backend_bucket" {
  value       = aws_s3_bucket.state.bucket
  description = "S3 bucket name for Terraform state"
}

output "backend_region" {
  value       = var.region
  description = "Region where the backend lives"
}

output "backend_dynamodb_table" {
  value       = aws_dynamodb_table.lock.name
  description = "DynamoDB table name for state locking"
}

# A ready-to-paste backend block
output "backend_snippet" {
  value = <<EOT
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.state.bucket}"
    key            = "REPLACE_ME/path/to/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${aws_dynamodb_table.lock.name}"
    encrypt        = true
  }
}
EOT
  description = "Copy this into your future Terraform projects (update 'key')."
}

