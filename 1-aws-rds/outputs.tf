output "rds_instance_identifier" {
  value       = aws_db_instance.db_instance.id
  description = "RDS instance identifier"
}

output "rds_host" {
  value       = aws_db_instance.db_instance.address
  description = "RDS host address"
}

output "rds_port" {
  value       = aws_db_instance.db_instance.port
  description = "RDS instance port"
}
