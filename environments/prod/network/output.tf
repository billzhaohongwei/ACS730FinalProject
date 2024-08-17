# Output Non Prod VPC ID
output "vpcId" {
  value = module.my_module.vpcId
}

# Output public subnet ID
output "publicSubnetId" {
  value = module.my_module.publicSubnetId
}

# Output Non Prod private subnet ID
output "privateSubnetId" {
  value = module.my_module.privateSubnetId
}

output "publicSubnetCount" {
  value = module.my_module.publicSubnetCount
}

# Output Prod private subnet ID
output "privateSubnetCount" {
  value = module.my_module.privateSubnetCount
}