resource "kubernetes_cron_job" "probe-mysql" {
  count = "${var.include_sql_test ? 1 : 0}"
  metadata {
    name = "probe-mysql-${var.kube_namespace}"
    namespace = "${var.kube_namespace}"
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 3
    backoff_limit                 = 1
    schedule                      = "*/5 * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 0
    job_template {
      metadata {}
      spec {
        backoff_limit = 1
        template {
          metadata {}
          spec {
            container {
              volume_mount {
                name       = "mysql-credentials"
                mount_path = "/mysql-credentials"
              }
              name    = "mysql"
              image   = "mysql"

              command =  ["mysql"]
              args    =  [
                "--defaults-extra-file=/mysql-credentials/client.cnf",
                "-h${var.proxy_service_name}",
                "-u${var.cloudsql_user}",
                "-e SELECT COUNT(*) FROM information_schema.SCHEMATA"
              ]
            }
            volume {
              name = "mysql-credentials"

              secret {
                secret_name = "mysql-credentials"
              }
            }
            restart_policy = "Never"
          }
        }
      }
    }
  }
}
