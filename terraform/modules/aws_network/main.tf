# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  defaultTags = merge(var.defaultTags, { "Env" = var.env })
}

# Create the non prod VPC 
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpcCidr
  instance_tenancy = "default"
  tags             = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-vpc" })
}


# Add public subnets in VPC
resource "aws_subnet" "publicSubnet" {
  count             = length(var.publicCidrBlocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.publicCidrBlocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-Public-Subnet-${count.index}" })
}

# Add private subnets in VPC
resource "aws_subnet" "privateSubnet" {
  count             = length(var.privateCidrBlocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.privateCidrBlocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-Public-Subnet-${count.index}" })
}


# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-Igw" })
}

# Elastic IP for NAT Gateway
resource "aws_eip" "natEip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "webserverNat" {
  allocation_id = aws_eip.natEip.id
  subnet_id     = aws_subnet.publicSubnet[0].id
  tags          = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-NAT" })
}

# Route table with a new route to direct traffic towards internet gateway igw
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-PublicRouteTable" })
}

# Associate subnets with the custom route table
resource "aws_route_table_association" "publicRouteTableAssociation" {
  count          = length(var.publicCidrBlocks)
  subnet_id      = aws_subnet.publicSubnet[count.index].id
  route_table_id = aws_route_table.publicRouteTable.id
}

# Route table with a new route to direct traffic towards NAT gateway
resource "aws_route_table" "privateRouteTable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.webserverNat.id
  }
  tags = merge(var.defaultTags, { Name = "${var.prefix}-${var.env}-PrivateRouteTable" })
}

# Associate subnets with the private route table
resource "aws_route_table_association" "privateRouteTableAssociation" {
  count          = length(var.privateCidrBlocks)
  subnet_id      = aws_subnet.privateSubnet[count.index].id
  route_table_id = aws_route_table.privateRouteTable.id
}
/*
data "aws_route_table" "prodMainRtb" {
  count  = var.env == "prod" ? 1 : 0
  vpc_id = aws_vpc.vpcProd[0].id
}
*/
