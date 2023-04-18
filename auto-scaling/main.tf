

# Create two public subnet in main vpc  
resource "aws_subnet" "pubsubnet1" {
  vpc_id                  = var.tf-vpc-id
  cidr_block              = "172.31.24.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "pubsubnet2" {
  vpc_id                  = var.tf-vpc-id
  cidr_block              = "172.31.23.0/24"
  map_public_ip_on_launch = true
}

resource "aws_launch_template" "weblaunch" {
  name                   = "weblaunch3"
  image_id               = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = filebase64("apache.sh")
  vpc_security_group_ids = [aws_security_group.tf-asg-access.id]

}

# auto scaling group

resource "aws_autoscaling_group" "web-tier" {
  name                = "web-tier-autoscaling-group"
  max_size            = 0
  min_size            = 0
  desired_capacity    = 0
  vpc_zone_identifier = [aws_subnet.pubsubnet1.id, aws_subnet.pubsubnet2.id]


  launch_template {
    id      = aws_launch_template.weblaunch.id
    version = "$Latest"
  }
}


