data "aws_secretsmanager_secret" "roboshop" {
  name = "roboshop.secrets"
}

data "aws_secretsmanager_secret_version" "roboshop" {
  secret_id = data.aws_secretsmanager_secret.roboshop.id
}