## -- database main.tf --- ##
# resource "aws_db_instance" "terraform-db" {
#   allocated_storage    = var.allocated_storage
#   db_name              = "terraformdb"
#   engine               =  var.engine
#   engine_version       =  var.engine_version
#   instance_class       =  var.instance_class
#   username             =  var.username
#   password             =  var.password
#   parameter_group_name =  var.parameter_group_name
#   skip_final_snapshot  =  var.skip_final_snapshot
#   vpc_security_group_ids = var.security_group_id
#   db_subnet_group_name =  var.db_subnet_group_name
# }