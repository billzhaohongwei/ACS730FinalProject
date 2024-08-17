# Output public IP of EC2 instance

output "BastionIp" {
  value = aws_instance.webServer2.public_ip
}

/*
# Output private IPs of vms in private subnet
output "webserver_private_ip" {
  value = [for vm in aws_instance.webserver : vm.private_ip]
}

output "prod_vm_private_ip" {
  value = [for vm in aws_instance.prod_vm : vm.private_ip]
}
*/