variable "lambda_zip_file" {
  description = "Path to the Lambda deployment zip file"
  type        = string
}
variable "lambda_role_arn" {
  description = "ARN of the IAM role for the Lambda function"
  type        = string
}

