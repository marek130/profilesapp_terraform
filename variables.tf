variable "token" {
  type        = string
  description = "Github token to connect github repo"
}

variable "repository" {
  type        = string
  description = "Github repo url"
}

variable "branch_name" {
  type        = string
  description = "AWS Amplify App Repo Branch Name"
  default     = "main"
}

variable "iam_service_role_arn" {
  type        = string
  description = "Service role - Amplify requires permissions to deploy backend resources in your account"
}
