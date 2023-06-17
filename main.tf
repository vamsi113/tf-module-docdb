resource "aws_docdb_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-docdb"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-docdb"
  }
}

resource "aws_docdb_cluster" "docdb" {
  depends_on              = [aws_docdb_subnet_group.default]

  cluster_identifier      = "${var.env}-${var.name}-roboshop-docdb"
  engine                  =  var.engine
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["DOCDB_USER"]
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["DOCDB_PASS"]
  skip_final_snapshot     = true
  db_subnet_group_name    = "${var.env}-${var.name}-roboshop-docdb"
}