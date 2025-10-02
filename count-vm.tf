data "yandex_compute_image" "ubuntu-2004-lts" {
  family = var.os_image_web
}

resource "yandex_compute_instance" "web" {
  count       = var.yandex_compute_instance_web[0].count_vms
  name        = "${var.yandex_compute_instance_web[0].vm_name}-${count.index + 1}" 
  platform_id = var.yandex_compute_instance_web[0].platform_id
  zone        = var.default_zone

  resources {
    cores         = var.yandex_compute_instance_web[0].cores
    memory        = var.yandex_compute_instance_web[0].memory
    core_fraction = var.yandex_compute_instance_web[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = var.boot_disk_web[0].type
      size     = var.boot_disk_web[0].size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id] 
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
  }

  scheduling_policy {
    preemptible = true 
  }
}
