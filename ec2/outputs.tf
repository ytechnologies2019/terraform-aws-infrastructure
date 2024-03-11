output "aws_instance_ids" {
  value = aws_instance.ec2_create.*.id
}
