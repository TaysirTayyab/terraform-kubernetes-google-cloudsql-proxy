resource "kubernetes_secret" "mysql_credentials" {
  metadata {
    name      = "mysql-credentials"
    namespace = "${var.kube_namespace}"
  }

  data {
    "client.cnf" = "[client] \npassword=\"${var.cloudsql_passwd}\""
  }

  type = "kubernetes.io/opaque"
}
