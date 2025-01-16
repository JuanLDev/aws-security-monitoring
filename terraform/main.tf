module "guardduty" {
  source            = "./modules/guardduty"
  multi_account     = false
  member_account_id = "277707129094" # Replace with the actual member account ID
  member_email      = "jluislugo30@gmail.com" 
}

module "iam_roles" {
  source            = "./modules/iam-roles"
  aws_region          = var.aws_region
  aws_account_id      = var.aws_account_id
}

module "lambda" {
  source              = "./modules/lambda"
  lambda_zip_file     = "../lambda_function/lambda_function.zip" 
  lambda_role_arn     = module.iam_roles.lambda_role_arn
}
module "s3" {
  source      = "./modules/s3"
  bucket_name = "guardduty-findings-${var.environment}" 
  environment = var.environment
}

