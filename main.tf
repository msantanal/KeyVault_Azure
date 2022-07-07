data "azurerm_resource_group" "rg_oracle" {
  name = var.resource_group_name
}

resource"azurerm_key_vault" "keyvault_oracle" {
  name                = var.name_keyvault
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_oracle.name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_keyvault
  #add permission
  access_policy {
    tenant_id         = data.azurerm_config.current.tenant_id
    object_id         = data.azurerm.config.curent.object_id
  
  secret_permissions = {
    "get"
    "delete"
    "list"
    "recover"
    "set"
  }
}
}
  tags = {
    Environment = "Deployment"
  }
}

# Generate Ramdon String
resource "random_string" "random_passwd" {
  length                       = "14"
  special                      = "true"
}
# Create the secret for user
resource "azurerm_key_vault_secret" "user_secret" {
  name                         = var.usersecret_name
  value                        = random_string.random_passwd.result
  key_vault_id                 = azurerm_key_vault.rg_oracle.id
}
# Create the secret for password
resource "azurerm_key_vault_secret" "pass_secret" {
  name                         = var.passwordsecret_name
  value                        = random_string.random_passwd.result
  key_vault_id                 = azurerm_key_vault.rg_oracle.id
}
