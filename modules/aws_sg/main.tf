# Use remote state to retrieve the data from state file of networking
/*
data "terraform_remote_state" "remote_state" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.s3BucketName // Bucket from where to GET Terraform State
    key    = var.s3ObjKeyname // Object name in the bucket to GET Terraform State
    region = "us-east-1"      // Region where bucket created
  }
}
*/

# Security Group of Bastion
resource "aws_security_group" "bastionSg" {
  name        = "allow_ssh_bastion"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = var.vpcId

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.defaultTags,
    {
      "Name" = "${var.prefix}-${var.env}-Bastion-Sg"
    }
  )
}

# Security Group for web server
resource "aws_security_group" "webSg" {
  name        = "allow_ssh_webserver"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = var.vpcId

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.defaultTags,
    {
      "Name" = "${var.prefix}-${var.env}-Webserver-Sg"
    }
  )
}
