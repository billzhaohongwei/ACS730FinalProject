output "elbDnsName" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.elb1.dns_name
}