variable "instance_count" {
  type = number
}

variable "public_subnet" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)  # Corrected type definition
}

variable "key_name" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "user_data" {
  type = string
}

