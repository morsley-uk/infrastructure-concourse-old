###############################################################################
# VPC - Virtual Private Cloud
###############################################################################

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.24.0

module "vpc" {
  
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"

  name = "morsley-uk-concourse-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Concourse"
  }
  
}

###############################################################################
# AMI - Amazon Machine Image
###############################################################################

# https://cloud-images.ubuntu.com/locator/ec2/

data "aws_ami" "ubuntu" {
  
  most_recent = true
  owners = ["099720109477"] # Canonical
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

###############################################################################
# Key Pair
###############################################################################

# https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws/0.2.0

module "key-pair" {
  
  source  = "terraform-aws-modules/key-pair/aws"
  version = "0.2.0"
  
  key_name = "morsley-uk-concourse"
  public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEqt9Wta8swnodwBJA5Hg3Ve3yXWATie4lPXklMC/Px2aEMNcnHP0rbJARAGYXKMxflQ+txoUtFbx7Ub4b4N2fbPsEc6oyMmyNJNy5cSk1q6hoyS9rB1AvCZjZEOvLC4BZFNimwQpNxOhxsC4rJhzrMW2+C3aETEBDQkT5UEPvOQIDAQAB"
  
}

###############################################################################
# EC2 - Elastic Compute Cloud
###############################################################################

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/2.12.0

module "ec2-instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name                   = "concourse"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "morsley-uk-concourse"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Concourse"
  }
  
}

###############################################################################
# Route 53
###############################################################################

# concourse.morsley.io

data "aws_route53_zone" "morsley" {
  name         = "morsley.io."
  private_zone = false
}

output "route_53_name_servers" {
  value = data.aws_route53_zone.morsley.name_servers
}