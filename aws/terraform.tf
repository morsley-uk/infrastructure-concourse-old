###############################################################################
# TERRAFORM
###############################################################################

terraform {

  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "morsley-uk-terraform-backend"
    key            = "infrastructure"
    region         = "eu-west-2"
    dynamodb_table = "tfstatelock"
    encypt         = true
  }
  
}