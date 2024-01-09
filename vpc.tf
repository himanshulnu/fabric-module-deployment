locals {
  prefix = "fr-mod-dpy"
}

module "vpc" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc?ref=v28.0.0"
  project_id = var.project_id
  name       = "${local.prefix}-vpc"
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = "${local.prefix}-vpc-subnet-as1"
      region        = "asia-south1"
    }
  ]
}


module "nat" {
  source         = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-cloudnat?ref=v28.0.0"
 project_id = var.project_id
  region        = "asia-south1"
  name           = "${module.vpc.name}-nat"
  router_network = module.vpc.name
}