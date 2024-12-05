resource "aws_s3_bucket" "guardduty_findings" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Environment = var.environment
    Name        = "guardduty-findings"
  }
}

resource "aws_s3_bucket_policy" "guardduty_findings_policy" {
  bucket = aws_s3_bucket.guardduty_findings.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::277707129094:user/popeye"
        },
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = [
          "${aws_s3_bucket.guardduty_findings.arn}",
          "${aws_s3_bucket.guardduty_findings.arn}/*"
        ]
      }
    ]
  })
}


resource "aws_s3_bucket_versioning" "guardduty_findings" {
  bucket = aws_s3_bucket.guardduty_findings.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "guardduty_findings" {
  bucket = aws_s3_bucket.guardduty_findings.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
