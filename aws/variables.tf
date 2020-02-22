###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
}

variable "access_key" {}

variable "secret_key" {}

variable "key_name" {
  default = "morsley-uk-concourse"
}

variable "public_keys_bucket" {
  default = "morsley-uk-concourse-public-keys"
}

variable "private_keys_bucket" {
  default = "morsley-uk-concourse-private-keys"
}

//variable "keys_bucket_name" {
//  default
//}