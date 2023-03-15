resource "google_vpc_access_connector" "connector_region1" {
  count          = var.serverless_vpc_connector != null ? 1 : 0
  project        = var.project_id
  region         = var.default_region1
  network        = local.network_name
  name           = "vpc-connector-region1"
  ip_cidr_range  = var.serverless_vpc_connector.ip_cidr_range
  min_throughput = var.serverless_vpc_connector.min_throughput
  max_throughput = var.serverless_vpc_connector.max_throughput
}

resource "google_project_iam_member" "vpc_access" {
  for_each = local.serverless_vpc_access_sas
  project  = var.project_id
  role     = "roles/vpcaccess.user"
  member   = "serviceAccount:${each.value}"
}
