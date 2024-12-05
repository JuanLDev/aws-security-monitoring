output "bucket_name" {
  value = aws_s3_bucket.guardduty_findings.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.guardduty_findings.arn
}
