# Output public IP of EC2 instance

output "vmSgId" {
  value       = aws_security_group.vmSg.id
  description = "The ID of the private subnet vm's security group"
}

output "webServerSgId" {
  value       = aws_security_group.webSg.id
  description = "The ID of the public webserver security group"
}

output "elbSgId" {
  value       = aws_security_group.elbSg.id
  description = "The ID of the elb's security group"
}