variable "enable_service" {
  description = "Flag to enable or disable GuardDuty"
  type        = bool
  default     = true
}

variable "member_account_id" {
  description = "The AWS Account ID of the member account"
  type        = string
}


variable "member_email" {
  description = "Email for the member account (optional)"
  type        = string
}

variable "multi_account" {
  description = "Flag to enable multi-account setup"
  type        = bool
  default     = false
}

