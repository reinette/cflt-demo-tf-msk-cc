terraform {
	required_providers {
		confluent = {
			source = "confluentinc/confluent"
			version = "1.23.0"
		}
	}
}

resource "random" "id" {
	byte_length = 4
}
