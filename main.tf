## root/main.tf ##
module "vpc" {
  source           = "./vpc"
  vpc_cidr         = "10.1.0.0/16"
  public_sn_count  = 2
  private_sn_count = 3
  max_subnets      = 20
  public_subnet    = [for i in range(10, 102, 90) : cidrsubnet("10.1.0.0/16", "8", i)]
  private_subnet   = [for i in range(0, 254, 30) : cidrsubnet("10.1.0.0/16", "8", i)]
}

# module "database" {
#   source               = "./database"
#   allocated_storage    = var.allocated_storage
#   engine               = var.engine
#   engine_version       = var.engine_version
#   instance_class       = var.instance_class
#   username             = var.username
#   password             = var.password
#   parameter_group_name = var.parameter_group_name
#   skip_final_snapshot  = var.skip_final_snapshot
#   db_subnet_group_name = module.vpc.db_subnet_group
#   security_group_id = module.vpc.aws_vpc_security_group_ingress_rule
# }

# module "loadbalancer" {
#   source          = "./loadbalancer"
#   public_subnet   = module.vpc.public_subnet
#   security_groups = module.vpc.aws_vpc_security_group_ingress_rule
#   tg_port         = 80
#   vpc_id          = module.vpc.vpc_id
#   listener_port   = var.listener_port
# }

module "ec2" {
  source        = "./ec2"
  instance_count = 2
  public_subnet = module.vpc.public_subnet
  security_groups = module.vpc.aws_vpc_security_group_ingress_rule
  key_name = "login-key"
  associate_public_ip_address = true
  user_data = file("userdata.tpl")
}

# resource "aws_lb_target_group_attachment" "tg-and-ec2-aws_lb_target_group_attachment" {
#   count            = length(module.ec2.aws_instance_ids)
#   target_group_arn = module.loadbalancer.target_group
#   target_id        = module.ec2.aws_instance_ids[count.index]
#   port             = 80
# }





