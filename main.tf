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

  tags = merge(
    {
      Name = "codebuild-${var.name}-service-role"
    },
    var.tags
  )
}

resource "aws_iam_policy" "codebuild_base" {
  name  = "codebuild-base-${var.name}-policy"
  path  = "/service-role/"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid = "AllowCloudWatchAccess"
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/codebuild/${var.name}",
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/codebuild/${var.name}:*"
        ]
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      }
    ]
  })

  tags = merge(
    {
      Name = "codebuild-base-${var.name}-policy"
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "codebuild_base" {
  role        = aws_iam_role.this.name
  policy_arn  = aws_iam_policy.codebuild_base.arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/codebuild/${var.name}"
  retention_in_days = var.log_retention_days

  tags = merge(
    {
      Name = "/codebuild/${var.name}"
    },
    var.tags
  )
}

resource "aws_codebuild_project" "this" {
  name          = var.name
  service_role  = aws_iam_role.this.arn

  environment {
    type          = "LINUX_CONTAINER" # currently only supporting linux container builds
    compute_type  = var.compute_type

    image_pull_credentials_type = var.image_pull_credentials_type
    image                       = var.image
    privileged_mode             = var.privileged_mode
  }

  source {
    type      = var.source_type
    location  = local.source_location
    buildspec = var.buildspec
  }

  artifacts {
    # artifacts not supported in this build
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/codebuild/${var.name}"
    }
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
