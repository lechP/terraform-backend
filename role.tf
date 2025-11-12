resource "aws_iam_role" "terraform_ci" {
  name               = "TerraformCiRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_trust.json

  tags = merge(var.tags, {
    Name = "TerraformCiRole"
  })
}

# Attach both policies
resource "aws_iam_role_policy_attachment" "attach_backend" {
  role       = aws_iam_role.terraform_ci.name
  policy_arn = aws_iam_policy.tf_backend.arn
}

resource "aws_iam_role_policy_attachment" "attach_ec2" {
  role       = aws_iam_role.terraform_ci.name
  policy_arn = aws_iam_policy.tf_ec2_limited.arn
}
