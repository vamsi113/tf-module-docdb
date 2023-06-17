resource "null_resource" "load-schema" {
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.main]

  provisioner "local-exec" {
    command = <<EOF
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
unzip -o mongodb.zip
cd mongodb-main
curl -L -O https://truststore.pki.rds.amazonaws.com/us-east-1/us-east-1-bundle.pem
mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile us-east-1-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < catalogue.js
mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile us-east-1-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < users.js
EOF
  }
}