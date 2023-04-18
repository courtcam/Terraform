
# Create a security group to allow traffic from the internet
resource "aws_security_group" "tf-asg-access" {
  name   = var.instance_secgroup
  vpc_id = var.tf-vpc-id



  #Incoming traffic
  ingress {
    from_port   = var.ingress-port-ssh
    to_port     = var.ingress-port-ssh
    protocol    = "tcp"
    cidr_blocks = [var.ingress-cidr]
  }

  ingress {
    from_port   = var.ingress-port-http
    to_port     = var.ingress-port-http
    protocol    = "tcp"
    cidr_blocks = [var.ingress-cidr]

  }

  egress {
    from_port        = var.egress-port
    to_port          = var.egress-port
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
