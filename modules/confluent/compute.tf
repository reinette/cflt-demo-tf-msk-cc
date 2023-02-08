# ## Schema Registry data (assuming this already exists)
# data "confluent_schema_registry_region" "sr_cluster_region" {
# 	cloud = "${var.cloud}"
# 	region = "${var.region}"
# 	package = "ESSENTIALS"
# }

## Confluent Cloud Environment
resource "confluent_environment" "kafka_env" {
	display_name = "${var.kafka_env_name}-${random_id.id.hex}"

	lifecycle {
		prevent_destroy = false
	}
}

## Schema Registry Resource
resource "confluent_schema_registry_cluster" "sr_cluster" {
	package = local.package

	environment {
		id = confluent_environment.kafka_env.id
	}
	region {
		id = "us-east-1"
	}
	
	lifecycle {
		prevent_destroy = true
	}
}

## Kafka Cluster - Basic
resource "confluent_kafka_cluster" "kafka_cluster" {
	display_name = "${var.kafka_cluster_name}"
	availability = "${var.availability}"
	cloud = "${var.cloud}"
	region = "us-east-1"
	basic {}
	environment {
		id = confluent_environment.kafka_env.id
	}

	lifecycle {
		prevent_destroy = false
	}
}
