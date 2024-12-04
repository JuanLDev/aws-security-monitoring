module "guardduty" {
  source         = "./modules/guardduty"
  enable_service = var.enable_guardduty
}
