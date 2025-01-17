resource "aws_lambda_function" "guardduty_processor" {
  function_name = "guardduty-processor"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = var.lambda_zip_file
 
  environment {
    variables = {
      S3_BUCKET_NAME = "guardduty-findings-processed"
    }
  }
  
}
