resource "aws_guardduty_detector" "this" {
  enable = true

  finding_publishing_frequency = "FIFTEEN_MINUTES" # Publish findings every 15 minutes
  export_configuration {
    enable = true
    destination_arn = module.kinesis.kinesis_stream_arn
  }
}


resource "aws_guardduty_member" "member" {
  count              = var.multi_account ? 1 : 0 # Optional for multi-account setup
  account_id         = var.member_account_id
  detector_id        = aws_guardduty_detector.this.id
  email              = var.member_email
  invite             = true
}
