resource "aws_guardduty_detector" "this" {
  enable = true
}


resource "aws_guardduty_member" "member" {
  count              = var.multi_account ? 1 : 0 # Optional for multi-account setup
  account_id         = var.member_account_id
  detector_id        = aws_guardduty_detector.this.id
  email              = var.member_email
  invite             = true
}
