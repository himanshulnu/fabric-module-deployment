data "google_compute_instance_group" "all" {
  depends_on = [ module.nginx-mig ]
  name = "mig-test"
  zone = "asia-south1-a"
}
