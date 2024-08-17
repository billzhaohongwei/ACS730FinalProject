# Output public IP of EC2 instance

output "bastionSgId" {
  value       = aws_security_group.bastionSg.id
  description = "The ID of the bastion security group"
}

output "webServerSgId" {
  value       = aws_security_group.webSg.id
  description = "The ID of the webserver security group"
}