/***************************************************************
        storing tfstate file 
    ****************************************************************/

terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket-fr-mod-dpy"
    prefix = "terraform/state"
  }
}