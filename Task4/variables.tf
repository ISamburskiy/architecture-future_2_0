variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "token" {
  description = "IAM token or service account key"
  type        = string
  sensitive   = true
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "iac-demo"
}

variable "zone" {
  description = "Cloud zone (e.g., ru-central1-a)"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_cidr" {
  description = "CIDR for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_cores" {
  description = "Number of VM cores"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "VM memory in GB"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 50
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}
