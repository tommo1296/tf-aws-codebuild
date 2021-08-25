resource "aws_iam_policy" "codecommit" {
  count = var.source_type == "CODECOMMIT" ? 1 : 0
  name  = "codebuild-codecommit-${var.name}-policy"
  path  = "/service-role/"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCodeCommitGitPull"
        Effect    = "Allow"
        Resource  = "arn:aws:codecommit:eu-west-2:${data.aws_caller_identity.current.account_id}:${var.name}"
        Action    = "codecommit:GitPull"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codecommit" {
  count       = var.source_type == "CODECOMMIT" ? 1 : 0
  role        = aws_iam_role.this.name
  policy_arn  = aws_iam_policy.codecommit[0].arn
}
