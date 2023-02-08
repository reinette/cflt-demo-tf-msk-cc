##If you want to import an existing topic...
# data "confluent_kafka_topic" "topicName" {
#   kafka_cluster {
#     id = confluent_kafka_cluster.kafka_cluster.id
#   }
#   rest_endpoint 	= confluent_kafka_cluster.kafka_cluster.rest_endpoint
#   credentials {
#     key    = confluent_api_key.app_manager_kafka_cluster_key.id
#     secret = confluent_api_key.app_manager_kafka_cluster_key.secret
#   }
#   topic_name = "topicName"
# }

output "config" {
  value = confluent_kafka_topic.table18.config
}

## New datagen topic resource
resource "confluent_kafka_topic" "table18" {
  topic_name = "table18"
  #topic_name = data.confluent_kafka_topic.topics.topic_name
  partitions_count   = 4
  config = {
    "cleanup.policy"    = "compact"
    "max.message.bytes" = "12345"
    "retention.ms"      = "67890"
  }

  rest_endpoint   = confluent_kafka_cluster.kafka_cluster.rest_endpoint

  kafka_cluster {
    id = confluent_kafka_cluster.kafka_cluster.id
  }

  credentials {
    key    = confluent_api_key.app_manager_kafka_cluster_key.id
    secret = confluent_api_key.app_manager_kafka_cluster_key.secret
  }
}