output "kinesis_stream_arn" {
  value = aws_kinesis_stream.this.name
}
output "kinesis_stream_name" {
  value       = aws_kinesis_stream.this.name
  description = "The name of the Kinesis stream"
}
