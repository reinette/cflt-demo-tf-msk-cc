locals {
  description = "Resource created for 'Use Case 3 Group 18'"
  package = "ESSENTIALS"
#region = "us-east-1"
}

# variable "confluent_cloud_api_key" {
#   description = "Confluent Cloud API Key (also referred as Cloud API ID)"
#   type        = string
# }

# variable "confluent_cloud_api_secret" {
#   description = "Confluent Cloud API Secret"
#   type        = string
#   sensitive   = true
# }

variable "cloud" {
  description = "The cloud provider to host this."
  type = string
  default = "AWS"
}

variable "availability" {
  description = "The data durability you need."
  type = string
  default = "SINGLE_ZONE"
}

variable "kafka_cluster_name" {
  description = "The name the the Kafka cluster."
  type        = string
  default     = "uc3_cluster"
}

variable "kafka_env_name" {
  description = "The name the the Kafka environment."
  type        = string
  default     = "uc3_environment"
}

variable "sr_cluster_name" {
  description = "The name of the Schema Registry cluster."
  type        = string
  default     = "uc3_sr"
}