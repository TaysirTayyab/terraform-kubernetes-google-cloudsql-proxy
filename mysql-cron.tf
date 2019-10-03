resource "kubernetes_cron_job" "probe-mysql" {
  count = "${var.include_test ? 1 : 0}"
  metadata {
    name = "probe-mysql-${var.kube_namespace}"
    namespace = "${var.kube_namespace}"
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 0
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
              name    = "mysql"
              image   = "mysql"
              command = ["/bin/sh", "-c", "mysql -h ${var.proxy_service_name}  -u ${var.db_user} -p${var.db_passwd} -e 'SELECT COUNT(*) FROM information_schema.SCHEMATA'"]
            }
            restart_policy = "Never"
          }
        }
      }
    }
  }
}