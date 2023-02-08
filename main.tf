locals {
	name = "RSS"
	bucket_postfix = "${var.owner}-"
	tags = {
		"tf_owner"			= "RSS",
		"tf_owner_email"	= "rstephen@confluent.io",
		"tf_provenance"		= "github.com/reinette/tf-demo",
		"Owner"				= "RSS",
	}
	aws_region = "us-east-1"
	aws_region_alias = "use1"
}

module "confluent" {
	source = "./modules/confluent"
	# confluent_cloud_api_key = "abc"
	# confluent_cloud_api_secret = "abc"
	kafka_env_name = "uc3_environment"
	kafka_cluster_name = "uc3_cluster"
	sr_cluster_name = "uc3_sr"
}

module "aws" {
  source = "./modules/aws"
}