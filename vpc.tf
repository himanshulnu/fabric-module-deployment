locals {
  prefix = "fr-mod-dpy"
}

module "vpc" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc?ref=v28.0.0"
  project_id = "cft-seed-himanshu"
  name       = "${local.prefix}-vpc"
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = "${local.prefix}-vpc-subnet-as1"
      region        = "asia-south1"
    }
  ]
}