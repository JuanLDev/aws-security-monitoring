variable "region" {
  description = "AWS region for the project"
  default     = "us-west-2"
}

variable "enable_guardduty" {
  description = "Flag to enable or disable GuardDuty"
  default     = true
}
variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "us-west-2" # Change if needed
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
  default     = "277707129094" # Change if needed
}
variable "environment" {
  description = "The environment for the project"
  type        = string
  default     = "processed"
}
