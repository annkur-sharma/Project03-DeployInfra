output "out_vm_private_ips" {
  description = "Map of VM names to private IPs"
  value = {
    for k, vm in azurerm_linux_virtual_machine.child_vm :
    vm.name => vm.public_ip_address
  }
}
