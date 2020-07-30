# CHANGELOG

## v1.2.3
* [SAASOPS-676](https://jira.broadsoft.com/browse/SAASOPS-676) fixed a bug to properly escape passwords when writing to my.cnf file in test container

## v1.2.2
* Update CloudSQL proxy version to 1.16

## v1.2.1
* Save job history for better metrics visualization 

## v1.2.0
* Added support for a mysql connectivity test cron job
* Added variable cloudsql_user to specify a user to test the cloud sql instance connectivity.
* Added variable cloudsql_passwd to specify the user's password.
* Added variable include_sql_test to enable or disable the tests. Enabled by default.
  
## v1.1.0

* **BREAKING** added support for terraform kubernetes provider v1.8.0

## v1.0.1

* Fixed a bug where kubernetes secret was mounted incorrectly

## v1.0.0

Initial commit.
