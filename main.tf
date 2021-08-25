resource "aws_iam_role" "this" {
  name = "codebuild-${var.name}-service-role"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action  = "sts:AssumeRole"
        Effect  = "Allow"
        Sid     = ""

        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  name = "${var.name}-inline-policy"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid = "AllowCloudWatchAccess"
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:eu-west-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.name}",
          "arn:aws:logs:eu-west-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.name}/*"
        ]
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      }
    ]
  })
}
