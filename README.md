# Google CloudSQL Proxy

https://cloud.google.com/sql/docs/mysql/connect-kubernetes-engine

Deploys a CloudSQL proxy in a kubernetes cluster that can be used by applications to connect to a Google CloudSQL instance.

The proxy connects to the CloudSQL instance over SSL using an oauth service account (stored in a Kubernetes secret).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudsql_instance_id | The id of the CloudSQL instance. | string | - | yes |
| cloudsql_instance_project | The id of the GCP project where the instance is configured. | string | - | yes |
| cloudsql_instance_region | The GCP region where the CloudSQL instance is deployed. | string | - | yes |
| kube_cloudsql_credentials | The kubernetes secret in namespace that holds the cloudsql credentials. | string | - | yes |
| kube_cloudsql_credentials_key | The key in the secret for the credentials file. | string | - | yes |
| kube_namespace | The kubernetes namespace to deploy the proxy. | string | - | yes |
| pod_replicas | The number of replicas of the proxy to run. | number | `2` | no |
| proxy_deployment_name | The name to give to the proxy deployment. | string | `cloudsql-proxy` | no |
| proxy_service_name | The name to give to the proxy's service, which is used by containers to connect to the proxy. | string | `cloudsql-proxy` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_name | The name of the proxy service, which other pods use to connect to the proxy. |
