## vpc/main.tf ##
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
} 

resource "random_integer" "random" {
  min = 1
  max = 99
}

resource "aws_vpc" "terraform-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "terraform-vpc-${random_integer.random.id}"
    }
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_subnet" "public_subnet" {
  count      =var.public_sn_count
  vpc_id     = aws_vpc.terraform-vpc.id
  availability_zone = random_shuffle.az.result[count.index]
  cidr_block = var.public_subnet[count.index]

  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count      = var.private_sn_count
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = random_shuffle.az.result[count.index]

  tags = {
    Name = "private_subnet_${count.index +1}"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "terraform_public_rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "terraform_pub_route_table"
  }
}

resource "aws_route_table" "terraform_private_rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "terraform_pri_route_table"
  }
}

## Default Route Table
resource "aws_route" "default_routetable" {
  route_table_id            = aws_route_table.terraform_public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform-igw.id
}

#Public Subnet Association
resource "aws_route_table_association" "public_subnet_associate" {
  count = var.public_sn_count
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.terraform_public_rt.id
}

#Private Subnet Association
resource "aws_route_table_association" "private_subnet_associate" {
  count = var.private_sn_count
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.terraform_private_rt.id
}

##Subnet Group
# resource "aws_db_subnet_group" "rds_subnet_group" {
#   name       = "rds_subnet_group"
#   subnet_ids = aws_subnet.private_subnet.*.id
#   tags = {
#     Name = "rds_subnet_group"
#   }
# }


##Security Group
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "public_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_web" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_port" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



