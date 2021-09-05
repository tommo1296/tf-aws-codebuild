resource "aws_iam_policy" "packer" {
  count = var.packer_support ? 1 : 0
  name  = "codebuild-packer-${var.name}-policy"
  path  = "/service-role/"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "PackerSecurityGroupAccess"
        Action    = [
          "ec2:CreateSecurityGroup",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ]
        Effect    = "Allow"
        Resource  = "*"
      },
      {
        Sid       = "PackerAMIAccess"
        Action    = [
          "ec2:CreateImage",
          "ec2:RegisterImage",
          "ec2:DeregisterImage",
          "ec2:DescribeImages"
        ]
        Effect    = "Allow"
        Resource  = "*"
      },
      {
        Sid       = "PackerSnapshotAccess"
        Action    = [
          "ec2:CreateSnapshot",
          "ec2:DeleteSnaphot",
          "ec2:DescribeSnapshots"
        ]
        Effect    = "Allow"
        Resource  = "*"
      },
      {
        Sid       = "PackerInstanceAccess"
        Action    = [
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeInstances",
          "ec2:CreateTags"
        ]
        Effect    = "Allow"
        Resource  = "*"
      },
      {
        Sid       = "PackerKeyPairAccess"
        Action    = [
          "ec2:CreateKeyPair",
          "ec2:DeleteKeyPair",
          "ec2:DescribeKeyPairs"
        ]
        Effect    = "Allow"
        Resource  = "*"
      },
      {
        Sid       = "Validations"
        Action    = [
          "ec2:DescribeRegions",
          "ec2:DescribeSubnets",
          "ec2:DescribeVolumes"
        ]
        Effect    = "Allow"
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "packer" {
  count       = var.packer_support ? 1 : 0
  role        = aws_iam_role.this.name
  policy_arn  = aws_iam_policy.packer[0].arn
}
