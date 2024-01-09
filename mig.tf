module "nginx-template" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-vm?ref=v28.0.0"
  //source     = "./fabric/modules/compute-vm"
  project_id = var.project_id
  name       = "nginx-template1"
  zone       = "asia-south1-a"
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

module "nginx-mig" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-mig?ref=v28.0.0"
  //source            = "./fabric/modules/compute-mig"
  project_id        = var.project_id
  location          = "asia-south1-a"
  name              = "mig-test"
  target_size       = 2
  instance_template = module.nginx-template.template.self_link
}
