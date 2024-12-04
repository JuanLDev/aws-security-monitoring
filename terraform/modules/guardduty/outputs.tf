output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector"
  value       = aws_guardduty_detector.this.id
}
output "guardduty_status" {
  description = "The status of GuardDuty"
  value       = aws_guardduty_detector.this.enable
}
