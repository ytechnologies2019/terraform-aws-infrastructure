module "infrastructure" {
  source  = "app.terraform.io/terraform-aws-cicd/infrastructure/aws"
  version = "1.0.0"
  # insert required variables here
  aws_region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
