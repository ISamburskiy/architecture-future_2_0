terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }
  required_version = ">= 1.7.0"
}

provider "yandex" {
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  token = var.token
}

# Источник образа — автоматически берёт свежий Ubuntu 22.04 без OS Login
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Сеть
resource "yandex_vpc_network" "main_net" {
  name = "${var.prefix}-network"
}

# Подсеть
resource "yandex_vpc_subnet" "main_subnet" {
  name          = "${var.prefix}-subnet"
  network_id    = yandex_vpc_network.main_net.id
  v4_cidr_blocks = [var.subnet_cidr]
  zone          = var.zone
}

# Группа безопасности: SSH (22), HTTP (80), весь исходящий трафик
resource "yandex_vpc_security_group" "sg" {
  name        = "${var.prefix}-sg"
  network_id  = yandex_vpc_network.main_net.id

  ingress {
    protocol = "TCP"
    port     = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "TCP"
    port     = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol  = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Виртуальная машина
resource "yandex_compute_instance" "vm" {
  name = "${var.prefix}-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main_subnet.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg.id]
  }

  metadata = {
    ssh-keys = var.ssh_public_key
  }
}
