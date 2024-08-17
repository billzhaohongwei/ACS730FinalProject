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

# Use remote state to retrieve the data from state file of networking
data "terraform_remote_state" "remote_state" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.s3_bucket_name // Bucket from where to GET Terraform State
    key    = var.s3_obj_keyname // Object name in the bucket to GET Terraform State
    region = "us-east-1"        // Region where bucket created
  }
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}

# Create VM1 in public subnet 2 as displayed in Architecture Diagram
resource "aws_instance" "public1_vm" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_state.outputs.public_subnet_id[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-nonprod-public1-vm"
    }
  )
}

# Create bastion VM in public subnet 1
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_state.outputs.public_subnet_id[1]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  #  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-nonprod-BastionVM"
    }
  )
}

# deploy VM1 and VM2 into private subnets of nonprod VPC
resource "aws_instance" "webserver" {
  count                       = data.terraform_remote_state.remote_state.outputs.nonprod_private_subnet_count
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_state.outputs.nonprod_private_subnet_id[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.web_sg_nonprod.id]
  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-nonprod-webserver-${count.index + 1}"
    }
  )
}

# deploy another 2 VMs into private subnets of prod VPC
resource "aws_instance" "prod_vm" {
  count                       = data.terraform_remote_state.remote_state.outputs.prod_private_subnet_count
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_state.outputs.prod_private_subnet_id[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.web_sg_prod.id]
  #  user_data                   = file("${path.root}/install_httpd.sh")
  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-prod_vm-${count.index + 1}"
    }
  )
}

