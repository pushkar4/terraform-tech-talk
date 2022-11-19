variable "allocated_storage" {
  type        = number
  description = "Rds storage size in GB"
  default     = 5
}

variable "instance_class" {
  type        = string
  description = "Rds instance class"
  default     = "db.t2.micro"
}

variable "multi_az" {
  type        = bool
  description = "True if high availability and failover support is required"
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  description = "True if high availability and failover support is required"
  default     = true
}

variable "storage_type" {
  type        = string
  description = "The RDS storage type. We change this value to 'io1' when we want to use provisioned IOPS"
  default     = "standard"  # / io1 / gp2
}
