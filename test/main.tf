module "codebuild_test" {
  source = "../"

  name = "test"

  tags = {
    Terraform = true
  }
}
