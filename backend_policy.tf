# Backend access: limit to the bucket & table created by this stack
data "aws_iam_policy_document" "tf_backend" {
  statement {
    sid     = "S3ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.state.arn
    ]
  }

  statement {
    sid     = "S3ObjectsRW"
    effect  = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["${aws_s3_bucket.state.arn}/*"]
  }

  statement {
    sid     = "DynamoDBLockTable"
    effect  = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      aws_dynamodb_table.lock.arn
    ]
  }
}

resource "aws_iam_policy" "tf_backend" {
  name        = "TerraformBackendAccess"
  description = "Allow Terraform to read/write state and locks"
  policy      = data.aws_iam_policy_document.tf_backend.json
}