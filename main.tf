resource "kubernetes_service" "service" {
  metadata {
    name      = "${var.proxy_service_name}"
    namespace = "${var.kube_namespace}"
  }

  spec {
    selector {
      app = "${var.proxy_deployment_name}"
    }

    port {
      port        = 3306
      name        = "cloudsql"
      target_port = 3306
    }
  }
}

resource "kubernetes_deployment" "cloudsql_proxy" {
  metadata {
    name      = "${var.proxy_deployment_name}"
    namespace = "${var.kube_namespace}"
  }

  spec {
    replicas = 2

    selector {
      app = "${var.proxy_deployment_name}"
    }

    template {
      metadata {
        labels {
          app = "${var.proxy_deployment_name}"
        }
      }

      spec {
        container {
          image = "gcr.io/cloudsql-docker/gce-proxy:1.12"
          name  = "${var.proxy_deployment_name}"

          command = [
            "/cloud_sql_proxy",
            "-dir=/cloudsql",
            "-instances=${var.cloudsql_instance_project}:${var.cloudsql_instance_region}:${var.cloudsql_instance_id}=tcp:0.0.0.0:3306",
            "-credential_file=/secrets/cloudsql/${var.kube_cloudsql_credentials_key}",
          ]

          # requires api_verison = rbac.authorization.k8s.io/v1
          # security_context {
          #   run_as_user                = 2     # non-root user
          #   allow_privilege_escalation = false
          # }

          port {
            container_port = 3306
          }

          volume_mount {
            name       = "cloudsql-credentials"
            mount_path = "/secrets/cloudsql"
            read_only  = true
          }

          volume_mount {
            name       = "ssl-certs"
            mount_path = "/etc/ssl/certs"
          }

          volume_mount {
            name       = "cloudsql"
            mount_path = "/cloudsql"
          }
        }

        volume {
          name = "cloudsql-credentials"

          secret {
            secret_name = "kube_cloudsql_credentials"
          }
        }

        volume {
          name = "ssl-certs"

          host_path {
            path = "/etc/ssl/certs"
          }
        }

        volume {
          name = "cloudsql"

          empty_dir {}
        }
      }
    }
  }
}
