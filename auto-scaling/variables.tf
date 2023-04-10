
# MY instance AMI 

variable "instance_ami" {
  type    = string
  default = "ami-0fa1de1d60de6a97e "
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
  default = "web-sg"
}