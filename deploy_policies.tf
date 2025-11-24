
data "aws_iam_policy_document" "tf_ec2_policy" {
  statement {
    sid    = "DescribeBasics"
    effect = "Allow"
    actions = [
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcAttribute",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ManageSecurityGroups"
    effect = "Allow"
    actions = [
      "ec2:CreateSecurityGroup",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:DescribeSecurityGroups",
      "ec2:DeleteSecurityGroup",
    ]
    resources = ["*"]
  }

  # Launch instances
  statement {
    sid       = "RunInstances"
    effect    = "Allow"
    actions   = ["ec2:RunInstances"]
    resources = ["*"]
  }

  statement {
    sid    = "ENIManagementForRunInstances"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:AttachNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeNetworkInterfaceAttribute",
    ]
    resources = ["*"]
  }

  # Allow termination and stop/start
  statement {
    sid    = "Lifecycle"
    effect = "Allow"
    actions = [
      "ec2:TerminateInstances",
      "ec2:ModifyInstanceAttribute",
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = ["*"]
  }

  # Allow tagging created instances (Terraform commonly tags)
  statement {
    sid       = "TagInstances"
    effect    = "Allow"
    actions   = ["ec2:CreateTags", "ec2:DeleteTags"]
    resources = ["*"]
  }

  # Allow EBS volume management
  statement {
    sid    = "EBSManagement"
    effect = "Allow"
    actions = [
      "ec2:CreateVolume",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:DeleteVolume"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "tf_ec2_limited" {
  name        = "TerraformEC2"
  description = "Allow Terraform to launch EC2 instances and manage their lifecycle"
  policy      = data.aws_iam_policy_document.tf_ec2_policy.json
}

data "aws_iam_policy_document" "tf_efs_policy" {
  statement {
    sid    = "CreateAndDeleteEFS"
    effect = "Allow"
    actions = [
      "elasticfilesystem:CreateFileSystem",
      "elasticfilesystem:DeleteFileSystem"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DescribeEFS"
    effect = "Allow"
    actions = [
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeLifecycleConfiguration",
      "elasticfilesystem:DescribeMountTargets",
      "elasticfilesystem:DescribeTags",
      "elasticfilesystem:DescribeMountTargetSecurityGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ManageMountTargets"
    effect = "Allow"
    actions = [
      "elasticfilesystem:CreateMountTarget",
      "elasticfilesystem:DeleteMountTarget"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "TagEFSResources"
    effect = "Allow"
    actions = [
      "elasticfilesystem:CreateTags",
      "elasticfilesystem:TagResource",
      "elasticfilesystem:DeleteTags",
      "elasticfilesystem:ListTagsForResource"
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "tf_efs" {
  name        = "TerraformEFS"
  description = "Allow Terraform manage EFS resources"
  policy      = data.aws_iam_policy_document.tf_efs_policy.json
}

data "aws_iam_policy_document" "tf_alb_policy" {
    statement {
        sid    = "ManageALB"
        effect = "Allow"
        actions = [
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:RemoveTags"
        ]
        resources = ["*"]
    }
}

resource "aws_iam_policy" "tf_alb" {
    name        = "TerraformALB"
    description = "Allow Terraform to manage Application Load Balancers"
    policy      = data.aws_iam_policy_document.tf_alb_policy.json
}