# Security Group of Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "allow_ssh_bastion"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = data.terraform_remote_state.remote_state.outputs.vpc_nonprod_id

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

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-bastion-sg"
    }
  )
}

# Security Group for web server in nonprod environment
resource "aws_security_group" "web_sg_nonprod" {
  name        = "allow_ssh_webserver"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = data.terraform_remote_state.remote_state.outputs.vpc_nonprod_id


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

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-nonprod-sg"
    }
  )
}

# Security Group for web server in nonprod environment
resource "aws_security_group" "web_sg_prod" {
  #  count            = var.env == "prod" ? 1 : 0
  name        = "allow_ssh_prod"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = data.terraform_remote_state.remote_state.outputs.vpc_prod_id

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

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-prod-sg"
    }
  )
}
