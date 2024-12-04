resource "aws_lambda_function" "guardduty_processor" {
  function_name = "guardduty-processor"
  role          = module.iam_roles.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = var.lambda_zip_file

  environment {
    variables = {
      KINESIS_STREAM_NAME = module.kinesis.kinesis_stream_name
    }
  }
}
