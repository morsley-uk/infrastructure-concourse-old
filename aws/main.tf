module "vpc" {
  
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"

  name = "morsley-uk-concourse-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Concourse"
  }
  
}

//module "ec2-instance" {
//
//  source  = "terraform-aws-modules/ec2-instance/aws"
//  version = "2.12.0"
//  
//  # insert the 10 required variables here
//  
//}