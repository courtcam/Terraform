#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

INSTANCES=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone) 
echo '<center><h1>This Amazon EC2 instance is located in Availability Zone: AZID </h1></center>' > /var/www/html/index.txt
sed "s/AZID/$INSTANCES/" /var/www/html/index.txt > /var/www/html/index.html