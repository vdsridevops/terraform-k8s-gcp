resource "google_compute_instance" "vm_instance" {
  count        = length(var.instance_name)
  name         = var.instance_name[count.index]
  machine_type = var.machine_type
  tags         = [var.instance_name[count.index]] 
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
        startup-script = <<SCRIPT
        echo "${var.passwd}" | passwd --stdin root
        sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd
        SCRIPT
    }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    network_ip    = var.ip[count.index]
    access_config {
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ${var.passwd} ssh-copy-id root@${var.ip[count.index]} -f -o StrictHostKeyChecking=no"
  }

  connection {
    type = "ssh"
    host = var.ip[count.index]
    user = "root"
    password = var.passwd
  }

}

resource "google_compute_firewall" "default" {
  name    = "k8s-worker-allow-http"
  network = "https://www.googleapis.com/compute/v1/projects/${var.project}/global/networks/default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["worker-http"]

}
