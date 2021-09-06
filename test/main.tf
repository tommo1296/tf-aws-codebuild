module "codebuild_test" {
  source = "../"

  name = "test"

  packer_support = true

  tags = {
    Terraform = true
  }
}
