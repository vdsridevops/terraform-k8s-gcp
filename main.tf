terraform {
  required_version = ">= 0.12.16"
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
  version = ">= 3.0"
}

module "gce-k8s-master" {
  source = "./modules/gce-k8s-master"
}

module "gce-k8s-worker" {
  source = "./modules/gce-k8s-worker"
}

resource "null_resource" "ansible-play" {
  depends_on = [module.gce-k8s-master, module.gce-k8s-worker]
  provisioner "local-exec" {
    command = <<EOT
$master
$worker
EOT
   
    environment = {
      master = "ansible-playbook -i ${var.path}/hosts ${var.path}/setup_master_node.yml"
      worker = "ansible-playbook -i ${var.path}/hosts ${var.path}/setup_worker_nodes.yml"
    }
  }
}
