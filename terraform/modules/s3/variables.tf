variable "bucket_name" {
  description = "The name of the S3 bucket for GuardDuty findings"
  type        = string
}

variable "environment" {
  description = "The environment tag for the bucket"
  type        = string
}
