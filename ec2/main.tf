data "aws_ami" "my_ami" {
  most_recent      = true
  owners           = ["099720109477"]
  filter {
    name   = "name"     
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]  ##-* To get the Update Image.
  }
}

resource "aws_instance" "ec2_create" {
  ami           = data.aws_ami.my_ami.id
  count         = var.instance_count
  instance_type = "t2.micro"
  associate_public_ip_address = var.associate_public_ip_address
  user_data = var.user_data
  key_name = var.key_name
   tags = {
    Name = "tf-server-0${count.index + 1}"
  }
  subnet_id = var.public_subnet[count.index % length(var.public_subnet)] ##
# With the use of the modulo operator %, the index will cycle back to the beginning of the subnet list once it reaches its end, allowing you to reuse the subnet IDs.
# For instance, if you have 3 instances (instance_count = 3) and 2 subnets in your list, the third instance will use the first subnet again (count.index % length(var.public_subnet) will result in 2 % 2, which is 0, the index of the first subnet).
# Ensure that your public_subnet list has at least two subnet IDs in it for this configuration to work as expected. Adjust the instance_count and public_subnet list accordingly based on your requirements.
  security_groups = var.security_groups
}







