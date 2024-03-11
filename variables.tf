## vpc/variables.tf
# variable "vpc_cidr" {
#   type = string
# }

variable "aws_region" {
  type = string
}

variable "access_key" {
  type      = string
  sensitive = true
}

# variable "secret_key" {
#   type      = string
#   sensitive = true
# }

# variable "allocated_storage" {
#   type = number
# }

# variable "engine" {
#   type = string
# }

# variable "engine_version" {
#   type = string
# }

# variable "instance_class" {
#   type = string
# }

# variable "username" {
#   type      = string
#   sensitive = true
# }

# variable "password" {
#   type      = string
#   sensitive = true
# }

# variable "parameter_group_name" {
#   type = string
# }

# variable "skip_final_snapshot" {
#   type = bool
# }

# variable "listener_port" {
#   type = string
# }

##Ec2 Keys
