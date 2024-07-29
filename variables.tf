variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}
variable "prefix" {
    type = string
    description = "prefix"
}
variable "region" {
    type = string
    description = "region"
}
variable "subnet1_cidr" {
    type = string
    description = "subnet1_cidr"
}
variable "subnet2_cidr" {
    type = string
    description = "subnet2_cidr"
}
variable "subnet3_cidr" {
    type = string
    description = "subnet3_cidr"
}
variable "subnet4_cidr" {
    type = string
    description = "subnet4_cidr"
}
variable "subnet5_cidr" {
    type = string
    description = "subnet5_cidr"
}
variable "subnet6_cidr" {
    type = string
    description = "subnet6_cidr"
}

variable "availability-zone1" {
    type = string
    description = "availability_zone_1"
}

variable "availability-zone2" {
    type = string
    description = "availability_zone_2"
}