# 1) Define the GitHub OIDC provider in the AWS account (one-time)
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.github_oidc_thumbprints
}

# 2) Trust policy allowing only your repo (and optional branch refs) to assume the role
data "aws_iam_policy_document" "github_oidc_trust" {
  statement {
    sid     = "GitHubOIDCAssumeRole"
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Limit to your repo and allowed refs (e.g., main)
    dynamic "condition" {
      for_each = var.allow_branches
      content {
        test     = "StringLike"
        variable = "token.actions.githubusercontent.com:sub"
        values   = ["repo:${var.github_org}/${var.github_repo}:ref:${condition.value}"]
      }
    }
  }
}
