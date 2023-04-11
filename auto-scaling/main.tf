# Create a VPC for our envirnoment 

resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main vpc"
  }
}

# Create two public subnet in main vpc  

resource "aws_subnet" "pubsubnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.100.15.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "pubsubnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.100.30.0/24"
  map_public_ip_on_launch = true
}


# Create a security group to allow traffic from the internet
resource "aws_security_group" "my-sg-rules" {
  name   = var.instance_secgroup
  vpc_id = aws_vpc.main.id


  #Incoming traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}




resource "aws_launch_template" "weblaunch" {
  name          = "weblaunch"
  image_id      = var.instance_ami
  instance_type = var.instance_type
  # iam_instance_profile = "profile-1"
  #security_groups = [var.instance_secgroup]
  key_name  = var.instance_keypair
  user_data = filebase64("apache.sh")
}

# auto scaling group

resource "aws_autoscaling_group" "web-tier" {
  name             = "web-tier-autoscaling-group"
  max_size         = 5
  min_size         = 2
  desired_capacity = 2
  #launch_configuration = aws_launch_template.weblaunch.name
  vpc_zone_identifier = [aws_subnet.pubsubnet1.id, aws_subnet.pubsubnet2.id]


  launch_template {
    id      = aws_launch_template.weblaunch.id
    version = "$Latest"
  }
}



# Create s3 bucket for remote backend  










