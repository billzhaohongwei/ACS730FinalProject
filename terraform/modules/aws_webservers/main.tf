# Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}
/*
# Use remote state to retrieve the data from state file of networking
data "terraform_remote_state" "remote_state" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.s3_bucket_name // Bucket from where to GET Terraform State
    key    = var.s3_obj_keyname // Object name in the bucket to GET Terraform State
    region = "us-east-1"        // Region where bucket created
  }
}
*/
# Define tags locally
locals {
  default_tags = merge(var.defaultTags, { "Env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "webKey" {
  key_name   = var.keyName
  public_key = file("${var.keyName}.pub")
}

# Create VM1 in public subnet 1 as displayed in Architecture Diagram
resource "aws_instance" "webServer1" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.publicSubnetIds[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.webServerSgId]
  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver1"
    }
  )
}

# Create VM2 in public subnet 2 as displayed in Architecture Diagram
resource "aws_instance" "webServer2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.publicSubnetIds[1]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.webServerSgId]
  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver2"
    }
  )
}

# Create VM1 in public subnet 2 as displayed in Architecture Diagram
resource "aws_instance" "webServer3" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.publicSubnetIds[2]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.webServerSgId]
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver3"
    }
  )
}

# Create VM1 in public subnet 2 as displayed in Architecture Diagram
resource "aws_instance" "webServer4" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.publicSubnetIds[3]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.webServerSgId]
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver4"
    }
  )
}

# Create VM5 in private subnet 1
resource "aws_instance" "webserver5" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.privateSubnetIds[0]
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.vmSgId]
  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver5"
    }
  )
}

# Create VM6 in private subnet 2
resource "aws_instance" "webserver6" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instanceType, var.env)
  key_name                    = aws_key_pair.webKey.key_name
  subnet_id                   = var.privateSubnetIds[1]
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.vmSgId]
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver6"
    }
  )
}

