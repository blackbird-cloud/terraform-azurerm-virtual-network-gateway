output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vgw.id
}

output "vpn_gateway_name" {
  description = "The name of the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vgw.name
}

output "vpn_gateway_sku" {
  description = "The SKU of the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vgw
}

output "public_ip" {
  description = "The public IP address configuration for the VPN Gateway"
  value       = azurerm_public_ip.vgw.ip_address
}

output "vpn_client_configuration" {
  description = "The VPN Client Configuration for the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vgw.vpn_client_configuration[0]
}

output "vpn_client_cert" {
  description = "The VPN Client Certificate for the VPN Gateway"
  value = {
    for k, v in tls_locally_signed_cert.client : k => v.cert_pem
  }
  sensitive = true
}

output "vpn_client_private_key" {
  description = "The VPN Client Private Key for the VPN Gateway"
  value = {
    for k, v in tls_private_key.client : k => v.private_key_pem
  }
  sensitive = true
}

output "vpn_server_cert" {
  description = "The VPN Server Certificate for the VPN Gateway"
  value       = tls_self_signed_cert.server.cert_pem
  sensitive   = true
}

output "vpn_client_thumbprints" {
  description = "The thumbprint of the VPN Client Certificate for the VPN Gateway"
  value       = local.vpn_client_thumbprints
}
