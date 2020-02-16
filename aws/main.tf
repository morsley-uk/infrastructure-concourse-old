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

data "aws_ami" "ubuntu" {
  
  most_recent = true
  owners = ["amazon"]
  
  filter {
    name = "platform"
    values = ["ubuntu"]
  }

  #Root device type: ebs 
  #Virtualization type: hvm 
  #ENA Enabled: Yes
  
}
//module "ec2-instance" {
//
//  source  = "terraform-aws-modules/ec2-instance/aws"
//  version = "2.12.0"
//
//  name                   = "concourse"
//  instance_count         = 1
//
//  ami                    = "ami-0fc20dd1da406780b"
//  instance_type          = "t2.micro"
//  key_name               = "user1"
//  monitoring             = true
//  vpc_security_group_ids = ["sg-12345678"]
//  subnet_id              = "subnet-eddcdzz4"
//
//  tags = {
//    Terraform   = "true"
//    Environment = "Development"
//    Operation   = "Concourse"
//  }
//  
//}