# VPC и Subnet для Web
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Subnet для DB - Задание 3
resource "yandex_vpc_subnet" "db" {
  name           = "${var.vpc_name}-db"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Data source для образов
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_family
}

# Web VM - Задание 2 (переменные), Задание 5 (locals), Задание 6 (vms_resources)
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }
}

# DB VM - Задание 3, 5, 6
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }
}
