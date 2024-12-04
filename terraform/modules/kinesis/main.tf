resource "aws_kinesis_stream" "guardduty_stream" {
  name             = "guardduty-stream"
  shard_count      = 1
  retention_period = 24 # Retain data for 24 hours
}
