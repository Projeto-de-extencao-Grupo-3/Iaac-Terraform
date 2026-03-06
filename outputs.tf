# FRONTEND 1
output "frontend_1_public_ip" {
  description = "Public IP of Frontend 1 instance"
  value       = aws_instance.frontend_grotrack.public_ip
}

output "frontend_1_private_ip" {
  description = "Private IP of Frontend 1 instance"
  value       = aws_instance.frontend_grotrack.private_ip
}

# FRONTEND 2

output "frontend_2_public_ip" {
  description = "Public IP of Frontend 2 instance"
  value       = aws_instance.frontend2_grotrack.public_ip
}

output "frontend_2_private_ip" {
  description = "Private IP of Frontend 2 instance"
  value       = aws_instance.frontend2_grotrack.private_ip
}

# BACKEND

output "backend_private_ip" {
  description = "Private IP of Backend instance"
  value       = aws_instance.backend_grotrack.private_ip
}

# DATABASE

output "db_private_ip" {
  description = "Private IP of Database instance"
  value       = aws_instance.db_grotrack.private_ip
}

# API

output "api_private_ip" {
  description = "Private IP of API instance"
  value       = aws_instance.api_grotrack.private_ip
}

# LOAD BALANCER

output "loadbalancer_dns" {
  description = "DNS of the Application Load Balancer"
  value       = aws_lb.grotrack_lb.dns_name
}