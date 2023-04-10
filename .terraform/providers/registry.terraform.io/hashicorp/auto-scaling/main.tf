# Create a VPC for our envirnoment 

resource "aws_vpc" "main" {
  cidr_block       = "10.172.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


resource "aws_launch_configuration" "stats-reader" {
  image_id             = var.instance_ami
  instance_type        = "var.instance_type"
  iam_instance_profile = "profile-1"
  security_groups      = ["<sg-1>"]
  key_name             = "key-1"
  user_data            = file("apache.sh")

}