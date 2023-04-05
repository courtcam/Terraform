# MY INstance name 

variable "instance_name" {
  type    = string
  default = "Jenkins-Instance"
}



# MY INstance AMI 

variable "instance_ami" {
  type    = string
  default = "ami-0aa2b7722dc1b5612"
}


# MY iNstance Type

variable "instance_type" {
  type    = string
  default = "t2.micro"
}



# Key pair for EC2 instance

variable "instance_keypair" {
  type    = string
  default = "AWSLAB"
}


# Secuirty group for EC2 instance

variable "instance_secgroup" {
  type    = string
  default = "IB_SSH_TESTING"
}



# S3 Bucket

variable "s3_bucket_name" {
  type    = string
  default = "my-tf-dev-test-bucket"
}


# VPC ID

variable "vpc_id" {
    description = "my vpc_id"
    type    = string
    default = "vpc-0258d21eed8eb7a31"
}


