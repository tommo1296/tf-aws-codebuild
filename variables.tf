variable "name" {
  type        = string
  description = "The name to give the CodeBuild job"
  default     = ""
}

variable "compute_type" {
  type        = string
  description = "The size of the container to use in build"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "image_pull_credentials_type" {
  type        = string
  description = "Credentials type to use in build CODEBUILD for aws managed SERVICE_ROLE for private registry"
  default     = "CODEBUILD"
}

variable "image" {
  type        = string
  description = "Image to use in the build"
  default     = "aws/codebuild/standard:5.0"
}

variable "privileged_mode" {
  type        = bool
  description = "Enable elevated privileges or build docker images"
  default     = false
}

variable "source_type" {
  type        = string
  description = "The source type eg git or s3.  Creates additional policies to allow codebuild access where required"
  default     = "CODECOMMIT"
}

variable "source_location" {
  type        = string
  description = "Location of the source code (default to name when CODECOMMIT)"
  default     = ""
}

variable "buildspec" {
  type        = string
  description = "The source location of the buildspec file within the source_type"
  default     = ""
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs produced by build logs"
  default     = 7
}

variable "tags" {
  type        = map
  description = "A map of strings to be merged with any default tags created by the module"
  default     = {}
}

variable "packer_support" {
  type        = bool
  description = "Turn on Packer support if CodeBuild job is intended for use with Packer"
  default     = false
}
