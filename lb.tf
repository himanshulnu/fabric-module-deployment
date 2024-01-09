module "nlb" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-lb-ext?ref=v28.0.0"
  //source     = "./fabric/modules/net-lb-ext"
  project_id = var.project_id
  region     = var.region
  name       = "nlb-test"
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
      zone      = "${var.region}-a"
      instances = data.google_compute_instance_group.all.instances
    }
  }
}