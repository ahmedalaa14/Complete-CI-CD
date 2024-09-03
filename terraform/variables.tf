# provider variables 

variable "region" {
  type = string
}

# network-module variables
variable "vpc_cidr" {}

variable "public_subnets" {
  type = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  type = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}