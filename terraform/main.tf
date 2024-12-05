module "guardduty" {
  source            = "./modules/guardduty"
  multi_account     = false
  member_account_id = "277707129094" # Replace with the actual member account ID
  member_email      = "jluislugo30@gmail.com" # Replace with the actual email
}
module "kinesis" {
  source       = "./modules/kinesis"
  stream_name  = "guardduty-stream"  # Replace with your desired stream name
}
module "iam_roles" {
  source            = "./modules/iam-roles"
  kinesis_stream_name = module.kinesis.kinesis_stream_name
  kinesis_stream_arn  = module.kinesis.kinesis_stream_arn
  aws_region          = var.aws_region
  aws_account_id      = var.aws_account_id
}

module "lambda" {
  source              = "./modules/lambda"
  lambda_zip_file     = "../lambda_function/lambda_function.zip" # Replace with the actual path
  lambda_role_arn     = module.iam_roles.lambda_role_arn
  kinesis_stream_name = module.kinesis.kinesis_stream_name
}

