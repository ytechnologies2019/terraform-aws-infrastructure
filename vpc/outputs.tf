## vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

output "aws_vpc_security_group_ingress_rule" {
  value = [aws_security_group.public_sg.id]
}

# output "db_subnet_group" {
#     value = aws_db_subnet_group.rds_subnet_group.name
# }

output "public_subnet" {
    value = aws_subnet.public_subnet.*.id
}
