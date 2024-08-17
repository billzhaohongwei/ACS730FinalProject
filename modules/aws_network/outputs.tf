# Output VPC ID
output "vpcId" {
  value = aws_vpc.vpc.id
}

# Output subnet ID
output "publicSubnetId" {
  value = [for subnet in aws_subnet.publicSubnet : subnet.id]
}

# Output subnet ID
output "privateSubnetId" {
  value = [for subnet in aws_subnet.privateSubnet : subnet.id]
}

# Output public subnet number
output "publicSubnetCount" {
  value = length(aws_subnet.publicSubnet)
}

# Output private subnet number
output "privateSubnetCount" {
  value = length(aws_subnet.privateSubnet)
}