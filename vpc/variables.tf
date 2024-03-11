## vpc/variables.tf
variable "vpc_cidr" {
  type = string
}

variable "public_subnet" {
  type = list
}

variable "private_subnet" {
  type = list
}

variable "public_sn_count" {
  type = number
}

variable "private_sn_count" {
  type = number
}

variable "max_subnets" {
  type = number
}
