variable "cloudsql_user" {
  type        = "string"
  description = "The user to login with for the sql tests."
}

variable "cloudsql_passwd" {
  type        = "string"
  description = "The password for the user for the tests."
}

variable "include_sql_test" {
  type        = "string"
  description = "True to include test, otherwise set to false or null."
}

variable "kube_namespace" {
  type        = "string"
  description = "The kubernetes namespace to deploy the proxy."
}

variable "kube_cloudsql_credentials" {
  type        = "string"
  description = "The kubernetes secret in namespace that holds the cloudsql credentials."
}

variable "kube_cloudsql_credentials_key" {
  type        = "string"
  description = "The key in the secret for the credentials file."
}

variable "kube_cloudsql_credentials_unique_id" {
  type = "string"

  description = <<EOF
Unique identifier for the cloudsql service account key. Used to trigger proxy
restart when the key identifier changes.
EOF
}

variable "pod_replicas" {
  type        = "string"
  default     = 2
  description = "The number of replicas of the proxy to run."
}

variable "cloudsql_instance_project" {
  type        = "string"
  description = "The id of the GCP project where the instance is configured."
}

variable "cloudsql_instance_region" {
  type        = "string"
  description = "The GCP region where the CloudSQL instance is deployed."
}

variable "cloudsql_instance_id" {
  type        = "string"
  description = "The id of the CloudSQL instance."
}

variable "proxy_deployment_name" {
  type        = "string"
  default     = "cloudsql-proxy"
  description = "The name to give to the proxy deployment."
}

variable "proxy_service_name" {
  type        = "string"
  default     = "cloudsql-proxy"
  description = "The name to give to the proxy's service, which is used by containers to connect to the proxy."
}
