#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h1>Name: Hongwei Zhao. Environment: Prod. Private IP is $myip</h1>"  >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd