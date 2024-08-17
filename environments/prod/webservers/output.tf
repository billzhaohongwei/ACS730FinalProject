# Output public IP of EC2 instance

output "bastionSgId" {
  value       = module.securityGroup.bastionSgId
  description = "The ID of the bastion security group"
}

output "webServerSgId" {
  value       = module.securityGroup.webServerSgId
  description = "The ID of the webserver security group"
}

# Output public IP of EC2 instance
/*
output "public_ip" {
  value = module.my_module.public_ip
}

output "webserver_private_ip" {
  value = module.my_module.webserver_private_ip
}

output "prod_vm_private_ip" {
  value = module.my_module.prod_vm_private_ip
}
*/