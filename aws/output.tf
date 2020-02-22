#output "vpc_id" {

#  value = data.aws_vpc.default
#   value = module.vpc.vpc_id

#}

#output "first_subnet" {

#  value = sort(data.aws_subnet_ids.public.ids)[0]

#}

#output "security_groups" {

#  value = data.aws_security_groups.default

#}

# output "public_subnets" {

#   value = module.vpc.public_subnets

# }

# output "private_subnets" {

#   value = module.vpc.private_subnets

# }

# output "security_group_id" {

#   value = module.vpc.default_security_group_id

# }

//output "key_fingerprint" {
//  
//  value = module.key-pair.this_key_pair_fingerprint
//  
//}

output "ami_id" {

  value = data.aws_ami.ubuntu.id

}

output "aws_instance_public_dns" {
  
  value = aws_instance.concourse.public_dns
  
}