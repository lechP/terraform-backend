
# Initial EC2 policy: only launch/terminate micro instances + basic describes
# Notes:
# - Restricts RunInstances to t3.micro via condition.
# - Allows tagging at launch (CreateTags on the instance).
# - Allows TerminateInstances for instances it can see.
# - Allows Describe* reads needed by Terraform.
data "aws_iam_policy_document" "tf_ec2_limited" {
  statement {
    sid     = "DescribeBasics"
    effect  = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeImages",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeAvailabilityZones"
    ]
    resources = ["*"]
  }

  # Launch only micro instances
  statement {
    sid     = "RunOnlyMicroInstances"
    effect  = "Allow"
    actions = ["ec2:RunInstances"]
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "ec2:InstanceType"
      values   = ["t3.micro"]
    }
  }

  # Allow termination and stop/start
  statement {
    sid     = "Lifecycle"
    effect  = "Allow"
    actions = [
      "ec2:TerminateInstances",
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = ["*"]
  }

  # Allow tagging created instances (Terraform commonly tags)
  statement {
    sid     = "TagInstances"
    effect  = "Allow"
    actions = ["ec2:CreateTags", "ec2:DeleteTags"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "tf_ec2_limited" {
  name        = "TerraformEC2MicroOnly"
  description = "Allow Terraform to launch only micro EC2 instances and manage their lifecycle"
  policy      = data.aws_iam_policy_document.tf_ec2_limited.json
}
