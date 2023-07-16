terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0"
    }
  }
  backend "gcs" {
      bucket = "playground-s-11-0644d044"
      prefix = "terraform/dev"
  }
}
provider "google" {
  project = "playground-s-11-0644d044"
}
module "web_app" {
  source = "../modules/web"
  env = "dev"
}
output "ip" {
  value = module.web_app.web_server_ip
}

