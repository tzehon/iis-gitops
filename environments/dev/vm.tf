# Create Google Cloud VMs | vm.tf

# Create web server template
resource "google_compute_instance_template" "web_server" {
  name_prefix                 = "${var.app_name}-${var.app_environment}-web-server-template"
  description          = "This template is used to create web server instances running IIS"
  instance_description = "Web Server running IIS"
  can_ip_forward       = false
  machine_type         = "e2-medium"
  tags                 = ["ssh","http"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "golden-windows-2021-04-16-435-35"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.private_subnet_1.name
  }

  lifecycle {
    create_before_destroy = true
  }
}