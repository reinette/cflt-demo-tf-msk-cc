locals {
  secrets = []
}

resource "aws_kms_key" "main" {
  description         = "KMS CMK for ${local.name}"
  enable_key_rotation = true

  tags = local.tags
}

resource "aws_secretsmanager_secret" "main" {
  for_each = toset(local.secrets)

  name        = "AmazonMSK_${each.value}_${random_id.id}"
  description = "Secret for ${local.name} - ${each.value}"
  kms_key_id  = aws_kms_key.main.key_id

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "main" {
  for_each = toset(local.secrets)

  secret_id = aws_secretsmanager_secret.main[each.key].id
  secret_string = jsonencode({
    username = each.value,
    password = "${each.key}123!" # do better!
  })
}

resource "aws_secretsmanager_secret_policy" "main" {
  for_each = toset(local.secrets)

  secret_arn = aws_secretsmanager_secret.main[each.key].arn
  policy     = <<-POLICY
  {
    "Version" : "2012-10-17",
    "Statement" : [ {
      "Sid": "AWSKafkaResourcePolicy",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "kafka.amazonaws.com"
      },
      "Action" : "secretsmanager:getSecretValue",
      "Resource" : "${aws_secretsmanager_secret.main[each.key].arn}"
    } ]
  }
  POLICY
}
