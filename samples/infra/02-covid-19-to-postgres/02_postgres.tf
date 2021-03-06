# NOTE: Requires AWS policy 'AmazonRDSFullAccess' on the terraform account

locals {
  pg_admin_user = "postgresadmin"
  pg_admin_pass = "asdfAS12"
}

output "summary" { value = module.postgres.summary }
module "postgres" {
  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  source        = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/postgres?ref=master"
  name_prefix   = local.name_prefix
  environment   = module.env.environment
  resource_tags = local.resource_tags

  # CONFIGURE HERE:

  identifier          = "pg-db"
  admin_username      = local.pg_admin_user
  admin_password      = local.pg_admin_pass
  skip_final_snapshot = true # allows simple DB deletion for POC environments

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  mysql_version       = "5.7.26"
  instance_class      = "db.t2.micro"
  jdbc_port           = 3306
  storage_size_in_gb  = 20

  */

}
