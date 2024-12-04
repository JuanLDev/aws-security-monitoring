resource "aws_guardduty_detector" "this" {
  enable = var.enable_service
}

resource "aws_guardduty_member" "member" {
  count               = var.enable_service ? 1 : 0
  account_id          = var.member_account_id # Optional for multi-account setup
  detector_id         = aws_guardduty_detector.this.id
  email               = var.member_account_email
  invite              = true
  disable_email_notification = false
}
