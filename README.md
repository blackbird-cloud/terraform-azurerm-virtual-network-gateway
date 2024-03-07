# <Cloud> <Main resource> Terraform module
A Terraform module which configures your <Cloud> <Main resource>. <Relevant docs>
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

## Example
```hcl

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.vgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.vgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [tls_cert_request.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_self_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network gateway will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual network gateway. | `string` | n/a | yes |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | The public IP address configuration for the virtual network gateway. | <pre>object({<br>    name              = optional(string, null)<br>    allocation_method = optional(string, "Dynamic")<br>    sku               = optional(string, "Basic")<br>    tags              = optional(map(string), {})<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network gateway. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the virtual network gateway. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet in which to create the virtual network gateway. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The type of the virtual network gateway. | `string` | n/a | yes |
| <a name="input_vpn_point_to_site"></a> [vpn\_point\_to\_site](#input\_vpn\_point\_to\_site) | The VPN Point-to-Site configuration for the virtual network gateway. | <pre>object({<br>    address_space         = list(string)<br>    aad_tenant            = optional(string, null)<br>    aad_audience          = optional(string, null)<br>    aad_issuer            = optional(string, null)<br>    radius_server_address = optional(string, null)<br>    radius_server_secret  = optional(string, null)<br>    vpn_client_protocols  = optional(list(string), null)<br>    vpn_auth_types        = optional(list(string), null)<br>    certificate = optional(object({<br>      name                  = string<br>      organization          = string<br>      validity_period_hours = number<br>    }), null)<br>    clients         = optional(list(string), null)<br>    revoked_clients = optional(list(string), null)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address configuration for the VPN Gateway |
| <a name="output_vpn_client_cert"></a> [vpn\_client\_cert](#output\_vpn\_client\_cert) | The VPN Client Certificate for the VPN Gateway |
| <a name="output_vpn_client_configuration"></a> [vpn\_client\_configuration](#output\_vpn\_client\_configuration) | The VPN Client Configuration for the VPN Gateway |
| <a name="output_vpn_client_private_key"></a> [vpn\_client\_private\_key](#output\_vpn\_client\_private\_key) | The VPN Client Private Key for the VPN Gateway |
| <a name="output_vpn_gateway_id"></a> [vpn\_gateway\_id](#output\_vpn\_gateway\_id) | The ID of the VPN Gateway |
| <a name="output_vpn_gateway_name"></a> [vpn\_gateway\_name](#output\_vpn\_gateway\_name) | The name of the VPN Gateway |
| <a name="output_vpn_gateway_sku"></a> [vpn\_gateway\_sku](#output\_vpn\_gateway\_sku) | The SKU of the VPN Gateway |
| <a name="output_vpn_server_cert"></a> [vpn\_server\_cert](#output\_vpn\_server\_cert) | The VPN Server Certificate for the VPN Gateway |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)
