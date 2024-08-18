# Output public IP of EC2 instance

output "BastionIp" {
  value = aws_instance.webServer2.public_ip
}

output "elbInstanceIds" {
  description = "List of instance IDs for webServer1 and webServer2"
  value       = tolist([aws_instance.webServer1.id, aws_instance.webServer2.id])
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