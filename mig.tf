/***************************************************************
    Comupte Instance template Creation
****************************************************************/
module "nginx-template" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-vm?ref=v28.0.0"
  project_id = var.project_id
  name       = "${local.prefix}-nginx-template"
  zone       = var.zone
  tags       = ["http-server", "ssh", "https-server"]
  network_interfaces = [{
    network    = module.vpc.name
    subnetwork = "${local.prefix}-vpc-subnet-as1"
    nat        = true
    addresses  = null
  }]
  create_template = true
  metadata = {
    startup-script = file("vm_startup_script.txt")
  }
}

/***************************************************************
    MIG Creation
****************************************************************/

module "nginx-mig" {
  source            = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-mig?ref=v28.0.0"
  project_id        = var.project_id
  location          = var.zone
  name              = "${local.prefix}-mig"
  target_size       = 2
  instance_template = module.nginx-template.template.self_link
}
