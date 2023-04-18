# MY instance AMI 

variable "instance_ami" {
  type    = string
  default = "ami-069aabeee6f53e7bf"
}



# MY instance Type

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
  default = "tf-web-sg"

}


# S3 Bucket

variable "s3_bucket_name" {
  type    = string
  default = "tf-remote-backend-bucket-cc"
}


# VPC ID

variable "tf-vpc-id" {
  type    = string
  default = "vpc-0258d21eed8eb7a31"
}


# internet geteway
variable "name-igw" {
  type    = string
  default = "tf-igw"
}


# dynamodb name
variable "dynamodb-table" {
  type    = string
  default = "terraform-state-lock-cc"

}


# dynamodb hask key for table
variable "dynamodb-hash-key" {
  type    = string
  default = "LockID"
}



# ingress cidr notation for ipv4
variable "ingress-cidr" {
  type    = string
  default = "0.0.0.0/0"
}
