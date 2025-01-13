variable "project_id" {
  description = "project id"
  type        = string
}

variable "default_region" {
  description = "The default region for resources"
}

variable "RAILS_MASTER_KEY" {
  description = "RAILS_MASTER_KEY"
  type        = string
}

variable "DB_HOST" {
  description = "DB_HOST"
  type        = string
}

variable "DB_PORT" {
  description = "DB_PORT"
  type        = string
}

variable "DB_NAME" {
  description = "DB_NAME"
  type        = string
}

variable "DB_USER" {
  description = "DB_USER"
  type        = string
}

variable "DB_PASS" {
  description = "DB_PASS"
  type        = string
}
