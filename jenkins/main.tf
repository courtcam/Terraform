resource "aws_instance" "Jenkins" {
    ami             = var.instance_ami
    instance_type   = var.instance_type
    security_groups = [var.instance_secgroup]
    key_name        = var.instance_keypair

  tags = {
    Name = var.instance_name
  }
  
  
	user_data = file("jenkins.sh")
}



resource "random_id" "random-generator" {

  byte_length = 8
}


resource "aws_s3_bucket" "tf-artifact-bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "J_Artifact_bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "jenkins-artifact-acl" {
  bucket = aws_s3_bucket.tf-artifact-bucket.id
  acl    = "private"
}



#Block Public Access
resource "aws_s3_bucket_public_access_block" "my-bucket-public-block" {
  bucket = aws_s3_bucket.tf-artifact-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_security_group" "my-sg-rules" {
  name = var.instance_secgroup
  vpc_id = var.vpc_id

  #Incoming traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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