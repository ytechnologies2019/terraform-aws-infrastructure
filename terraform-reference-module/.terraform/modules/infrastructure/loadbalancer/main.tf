# resource "aws_lb" "test" {
#   name               = "my-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = var.security_groups
#   subnets            = var.public_subnet
# }

# resource "aws_lb_target_group" "my-tg" {
#   name     = "my-tg"
#   port     = var.tg_port
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_lb_listener" "lb_to_tg" {
#   load_balancer_arn = aws_lb.test.arn
#   port              =  var.listener_port
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.my-tg.arn
#   }
# }

