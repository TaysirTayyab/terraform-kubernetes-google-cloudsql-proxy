# Google CloudSQL Proxy

https://cloud.google.com/sql/docs/mysql/connect-kubernetes-engine

Deploys a CloudSQL proxy in a kubernetes cluster that can be used by applications to connect to a Google CloudSQL instance.

The proxy connects to the CloudSQL instance over SSL using an oauth service account (stored in a Kubernetes secret).

## Providers

| Name | Version |
|------|---------|
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloudsql\_instance\_id | The id of the CloudSQL instance. | `string` | n/a | yes |
| cloudsql\_instance\_project | The id of the GCP project where the instance is configured. | `string` | n/a | yes |
| cloudsql\_instance\_region | The GCP region where the CloudSQL instance is deployed. | `string` | n/a | yes |
| cloudsql\_passwd | The password for the user for the tests. | `string` | n/a | yes |
| cloudsql\_user | The user to login with for the sql tests. | `string` | n/a | yes |
| include\_sql\_test | True to include test, otherwise set to false or null. | `string` | n/a | yes |
| kube\_cloudsql\_credentials | The kubernetes secret in namespace that holds the cloudsql credentials. | `string` | n/a | yes |
| kube\_cloudsql\_credentials\_key | The key in the secret for the credentials file. | `string` | n/a | yes |
| kube\_cloudsql\_credentials\_unique\_id | Unique identifier for the cloudsql service account key. Used to trigger proxy<br>restart when the key identifier changes. | `string` | n/a | yes |
| kube\_namespace | The kubernetes namespace to deploy the proxy. | `string` | n/a | yes |
| pod\_replicas | The number of replicas of the proxy to run. | `string` | `2` | no |
| proxy\_deployment\_name | The name to give to the proxy deployment. | `string` | `"cloudsql-proxy"` | no |
| proxy\_service\_name | The name to give to the proxy's service, which is used by containers to connect to the proxy. | `string` | `"cloudsql-proxy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_name | The name of the proxy service, which other pods use to connect to the proxy. |
