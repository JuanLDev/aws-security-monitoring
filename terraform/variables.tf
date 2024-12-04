variable "region" {
  description = "AWS region for the project"
  default     = "us-west-2"
}

variable "enable_guardduty" {
  description = "Flag to enable or disable GuardDuty"
  default     = true
}
