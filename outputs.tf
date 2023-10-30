// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "id" {
  value       = azurerm_windows_virtual_machine.public_vm.id
  description = "The ID of the Windows Virtual Machine."
}

output "private_ip_address" {
  value       = azurerm_windows_virtual_machine.public_vm.private_ip_address
  description = "The Primary Private IP Address assigned to this Virtual Machine"
}

output "private_ip_addresses" {
  value       = azurerm_windows_virtual_machine.public_vm.private_ip_addresses
  description = "A list of Private IP Addresses assigned to this Virtual Machine."
}

output "public_ip_address" {
  value       = azurerm_windows_virtual_machine.public_vm.public_ip_address
  description = "The Primary Public IP Address assigned to this Virtual Machine."
}

output "public_ip_addresses" {
  value       = azurerm_windows_virtual_machine.public_vm.public_ip_addresses
  description = "A list of Public IP Addresses assigned to this Virtual Machine."
}

output "virtual_machine_id" {
  value       = azurerm_windows_virtual_machine.public_vm.virtual_machine_id
  description = "The ID of the Virtual Machine."
}
