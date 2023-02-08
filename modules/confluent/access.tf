## Generate Confluent Cluster access keys
resource "confluent_api_key" "app_manager_kafka_cluster_key" {
    display_name = "app-manager-${var.kafka_env_name}-key-${random_id.id.hex}"
    description = "${local.description}"
    owner {
        id = confluent_service_account.app_manager.id
        api_version = confluent_service_account.app_manager.api_version
        kind = confluent_service_account.app_manager.kind
    }
    managed_resource {
        id = confluent_kafka_cluster.kafka_cluster.id
        api_version = confluent_kafka_cluster.kafka_cluster.api_version
        kind = confluent_kafka_cluster.kafka_cluster.kind
        environment {
            id = confluent_environment.kafka_env.id
        }
    }
    depends_on = [
        confluent_role_binding.app_manager_environment_admin
    ]
    
    lifecycle {
        prevent_destroy = true        
    }
}

## Schema Registry environment keys
resource "confluent_api_key" "sr_cluster_key" {
    display_name = "sr-${var.kafka_cluster_name}-key-${random_id.id.hex}"
    description = "${local.description}"
    owner {
        id = confluent_service_account.sr.id 
        api_version = confluent_service_account.sr.api_version
        kind = confluent_service_account.sr.kind
    }
    managed_resource {
        id = confluent_schema_registry_cluster.sr_cluster.id
        api_version = confluent_schema_registry_cluster.sr_cluster.api_version
        kind = confluent_schema_registry_cluster.sr_cluster.kind 
        environment {
            id = confluent_environment.kafka_env.id
        }
    }
    depends_on = [
      confluent_role_binding.sr_environment_admin
    ]
}

## Cluster keys
resource "confluent_api_key" "clients_kafka_cluster_key" {
    display_name = "clients-${var.kafka_cluster_name}-key-${random_id.id.hex}"
    description = "${local.description}"
    owner {
        id = confluent_service_account.clients.id
        api_version = confluent_service_account.clients.api_version
        kind = confluent_service_account.clients.kind
    }
    managed_resource {
        id = confluent_kafka_cluster.kafka_cluster.id
        api_version = confluent_kafka_cluster.kafka_cluster.api_version
        kind = confluent_kafka_cluster.kafka_cluster.kind
        environment {
            id = confluent_environment.kafka_env.id
        }
    }
    depends_on = [
        confluent_role_binding.clients_cluster_admin
    ]
}

## Confluent Service Accounts
resource "confluent_service_account" "app_manager" {
    display_name = "app-manager-${random_id.id.hex}"
    description = "${local.description}"
}
resource "confluent_service_account" "sr" {
    display_name = "sr-${random_id.id.hex}"
    description = "${local.description}"
}
resource "confluent_service_account" "clients" {
    display_name = "client-${random_id.id.hex}"
    description = "${local.description}"
}

## Confluent Service Account RBAC Rolebinding
resource "confluent_role_binding" "app_manager_environment_admin" {
    principal = "User:${confluent_service_account.app_manager.id}"
    role_name = "EnvironmentAdmin"
    crn_pattern = confluent_environment.kafka_env.resource_name
}
resource "confluent_role_binding" "sr_environment_admin" {
    principal = "User:${confluent_service_account.sr.id}"
    role_name = "EnvironmentAdmin"
    crn_pattern = confluent_environment.kafka_env.resource_name
}
resource "confluent_role_binding" "clients_cluster_admin" {
    principal = "User:${confluent_service_account.clients.id}"
    role_name = "CloudClusterAdmin"
    crn_pattern = confluent_kafka_cluster.kafka_cluster.rbac_crn
}