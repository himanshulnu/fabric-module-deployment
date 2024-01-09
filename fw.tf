/***************************************************************
    Firewall Rule Creation
****************************************************************/

module "firewall" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc-firewall?ref=v28.0.0"
  project_id = var.project_id
  network    = module.vpc.name
  default_rules_config = {
    ssh_ranges  = ["35.235.240.0/20"]
    ssh_tags    = ["ssh"]
    
    http_ranges = ["0.0.0.0/0"]
    http_tags   = ["http-server"]

    https_ranges = ["0.0.0.0/0"]
    https_tags   = ["http-server"]
  }
}