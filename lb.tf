/***************************************************************
    Fetching instance deatils of MIG
****************************************************************/

data "google_compute_instance_group" "all" {
  depends_on = [module.nginx-mig]
  name       = "${local.prefix}-mig-test"
  zone       = "asia-south1-a"
}

/***************************************************************
    Load Balancer Creation
****************************************************************/
module "nlb" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-lb-ext?ref=v28.0.0"
  project_id = var.project_id
  region     = var.region
  name       = "${local.prefix}-nlb"
  backends = [{
    group = module.nlb.groups.my-group.self_link
  }]
  forwarding_rules_config = {
    vip-one = {}
    vip-two = {
      ports = [80]
    }
  }
  group_configs = {
    my-group = {
      zone      = local.zone
      instances = data.google_compute_instance_group.all.instances
    }
  }
}