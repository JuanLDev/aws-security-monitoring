module "guardduty" {
  source            = "./modules/guardduty"
  multi_account     = false
  member_account_id = "277707129094" # Replace with the actual member account ID
  member_email      = "jluislugo30@gmail.com" # Replace with the actual email
}
module "kinesis" {
  source = "./modules/kinesis"
}
module "lambda" {
  source         = "./modules/lambda"
  lambda_zip_file = "lambda_function.zip"
}
