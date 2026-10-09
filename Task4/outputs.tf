output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "vm_private_ip" {
  description = "Private IP of the VM"
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "network_id" {
  value = yandex_vpc_network.main_net.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.main_subnet.id
}

output "security_group_id" {
  value = yandex_vpc_security_group.sg.id
}
