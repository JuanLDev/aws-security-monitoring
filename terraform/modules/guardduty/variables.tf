variable "enable_service" {
  description = "Flag to enable or disable GuardDuty"
  type        = bool
  default     = true
}

variable "member_account_id" {
  description = "Member account ID for multi-account setup (optional)"
  type        = string
  default     = ""
}

variable "member_account_email" {
  description = "Email for the member account (optional)"
  type        = string
  default     = ""
}
