variable "kinesis_stream_arn" {
  description = "The ARN of the Kinesis stream"
  type        = string
}
variable "kinesis_stream_name" {
  description = "The name of the Kinesis stream"
  type        = string
}
variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "us-west-2"
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
  default     = "277707129094"
}