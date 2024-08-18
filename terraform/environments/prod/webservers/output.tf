# Output public IP of EC2 instance

output "vmSgId" {
  value       = module.securityGroup.vmSgId
  description = "The ID of the private vm's security group"
}

output "webServerSgId" {
  value       = module.securityGroup.webServerSgId
  description = "The ID of the webserver security group"
}

output "elbSgId" {
  value       = module.securityGroup.elbSgId
  description = "The ID of the elb's security group"
}

output "elbDnsName" {
  description = "The DNS name of the load balancer."
  value       = module.elasticLoadBalancer.elbDnsName
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