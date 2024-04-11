resource "azurerm_public_ip" "vgw" {
  allocation_method   = var.public_ip.allocation_method
  location            = var.location
  name                = var.public_ip.name
  resource_group_name = var.resource_group_name
  sku                 = var.public_ip.sku
  tags                = var.tags
}

resource "azurerm_virtual_network_gateway" "vgw" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  type                = var.type
  tags                = var.tags

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.vgw.id
    name                          = azurerm_public_ip.vgw.name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  vpn_client_configuration {
    vpn_auth_types = ["AAD", "Certificate"]

    address_space = var.vpn_point_to_site.address_space

    aad_tenant   = var.vpn_point_to_site.aad_tenant
    aad_audience = var.vpn_point_to_site.aad_audience
    aad_issuer   = var.vpn_point_to_site.aad_issuer

    radius_server_address = var.vpn_point_to_site.radius_server_address
    radius_server_secret  = var.vpn_point_to_site.radius_server_secret

    root_certificate {
      name             = tls_self_signed_cert.server.subject[0].common_name
      public_cert_data = base64encode(tls_self_signed_cert.server.cert_pem)
    }

    vpn_client_protocols = var.vpn_point_to_site.vpn_client_protocols

    dynamic "revoked_certificate" {
      for_each = toset(var.vpn_point_to_site.revoked_clients)

      content {
        name       = revoked_certificate.key
        thumbprint = local.vpn_client_thumbprints[revoked_certificate.key]
      }
    }
  }

  depends_on = [
    tls_self_signed_cert.server,
    tls_locally_signed_cert.client,
    azurerm_public_ip.vgw
  ]
}

locals {
  vpn_client_thumbprints = {
    for k, v in data.external.user_thumbprints : k => v.result.thumbprint
  }
}

data "external" "user_thumbprints" {
  for_each = tls_locally_signed_cert.client

  program = ["${path.module}/thumbprint.sh", each.value.cert_pem]
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "server" {
  private_key_pem = trimspace(tls_private_key.server.private_key_pem)

  subject {
    common_name  = var.vpn_point_to_site.certificate.name
    organization = var.vpn_point_to_site.certificate.organization
  }

  validity_period_hours = var.vpn_point_to_site.certificate.validity_period_hours

  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]

  depends_on = [tls_private_key.server]
}

resource "tls_private_key" "client" {
  for_each  = toset(var.vpn_point_to_site.clients)
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_cert_request" "client" {
  for_each = toset(var.vpn_point_to_site.clients)

  private_key_pem = trimspace(tls_private_key.client[each.key].private_key_pem)

  subject {
    common_name  = each.key
    organization = var.vpn_point_to_site.certificate.organization
  }

  depends_on = [tls_private_key.server]
}

resource "tls_locally_signed_cert" "client" {
  for_each = toset(var.vpn_point_to_site.clients)

  cert_request_pem   = tls_cert_request.client[each.key].cert_request_pem
  ca_private_key_pem = tls_private_key.server.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.server.cert_pem

  validity_period_hours = var.vpn_point_to_site.certificate.validity_period_hours

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]

  depends_on = [tls_cert_request.client, tls_self_signed_cert.server, tls_private_key.server]
}
