data "google_compute_instance_group" "all" {
  name = "mig-test"
  zone = "asia-south1-a"
}
