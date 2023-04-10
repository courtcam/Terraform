# Create a VPC for our envirnoment 

resource "aws_vpc" "main" {
  cidr_block       = "10.172.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main vpc"
  }
}

# Create two public subnet in main vpc  

resource "aws_subnet" "pubsubnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.172.15.0/24"
}

resource "aws_subnet" "pubsubnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.172.30.0/24"
}





# Create a security group to allow traffic from the internet
resource "aws_security_group" "web-sg" {
  name_prefix = "web-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_launch_configuration" "stats-reader" {
  image_id             = var.instance_ami
  instance_type        = "var.instance_type"
  iam_instance_profile = "profile-1"
  security_groups      = ["web-sg"]
  key_name             = "key-1"
  user_data            = file("apache.sh")

}


# auto scaling group

resource "aws_autoscaling_group" "web-tier" {
  name                 = "web-tier-autoscaling-group"
  max_size             = 5
  min_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.web-tier.id
  vpc_zone_identifier  = [aws_subnet.pubsubnet1.id, aws_subnet.pubsubnet2.id]

  tag {
    key                 = "Name"
    value               = "web-tier-instance"
    propagate_at_launch = true
  }
}



# Create s3 bucket for remote backend  


resource "aws_s3_bucket" "web-tier" {
  bucket = "web-tier-bucket"
}










