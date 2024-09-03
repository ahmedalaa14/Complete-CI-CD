# Security Group VPC ID
variable "sg_vpc_id"{
    description = "VPC ID"
    type = string
}
# ec2 subnet id where instance will be launched
variable "ec2_subnet_id" {
    description = "Subnet ID where instance will be launched"
    type = string
}
# instance profile
variable "instance_profile"{
    description = "ec2 instance profile"
    type = string
}