# resource "confluent_connector" "source" {
#    environment {
#      id = confluent_environment.kafka_env.id
#    }
#    kafka_cluster {
#      id = confluent_kafka_cluster.kafka_cluster.id
#    }

#    config_sensitive = {}

# 	config_nonsensitive = {
# 		"connector.class"          = "DatagenSource"
# 	    "name"                     = "DatagenSourceConnector_0"
# 	    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
# 	    "kafka.service.account.id" = confluent_service_account.app-connector.id
# 	    "kafka.topic"              = confluent_kafka_topic.table18.topic_name
# 	    "output.data.format"       = "JSON"
# 	    "quickstart"               = "ORDERS"
# 	    "tasks.max"                = "1"
# 	}

# 	depends_on = [
# 	    confluent_kafka_acl.app-connector-describe-on-cluster,
# 	    confluent_kafka_acl.app-connector-write-on-target-topic,
# 	    confluent_kafka_acl.app-connector-create-on-data-preview-topics,
# 	    confluent_kafka_acl.app-connector-write-on-data-preview-topics,
# 	]

# 	lifecycle {
# 		prevent_destroy = true
# 	}
# }