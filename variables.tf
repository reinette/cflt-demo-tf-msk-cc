variable "key" {
  default = "rss-tf"
}

variable "owner" {
  default = "RSS"
  type = string
}

variable "name" {
  default = "ThisEnv"
  type = string
}

variable "kafka_connect_version" {
  description = "Kafka Connect version"
  type        = string
  default 	  = "3.3"
}

variable "tags" {
  description = "Tags for resources"
  type = map
  default = {
    "tf_owner"      = ""
    "tf_owner_email"  = ""
    "tf_provenance"   = ""
    "Environment"   = "dev"
  }
}