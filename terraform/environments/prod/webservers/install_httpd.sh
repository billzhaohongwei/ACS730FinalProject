#!/bin/bash
yum -y update

# Install Apache Web Server
yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Create directory for the images
mkdir -p /var/www/html/static/images

# Download images from S3 bucket
#aws s3 cp s3://acs730-final-hongweizhao/Seneca.png /var/www/html/static/images/Seneca.png
#aws s3 cp s3://acs730-final-hongweizhao/Seneca2.jpg /var/www/html/static/images/Seneca2.jpg

# Modify index.html to show team info and images
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOM > /var/www/html/index.html
<html>
<head>
    <title>hzhao101's webpage</title>
</head>
<body>
    <h1>This page is built by New Group4</h1>
    <h2>Member: Hongwei Zhao</h2>
    <p>Environment: Production</p>
    <p>Private IP is $myip<p>
</body>
</html>
EOM

# Restart Apache to apply the changes
systemctl restart httpd