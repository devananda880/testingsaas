resource "aws_secretsmanager_secret" "password" {
  name = var.secretmanager_name
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = <<EOF
{
  "username": "${aws_db_instance.default.username}",
  "password": "${random_password.password.result}",
  "host": "${aws_db_instance.default.address}"
}
EOF
}