data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}

data azurerm_client_config current {}

resource"azurerm_key_vault" "keyvault" {
  name                = var.name_keyvault
  location            = var.location
  resource_group_name = data.azurerm_resource_group.RG.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_keyvault
  #add permission
  access_policy {
    tenant_id         = data.azurerm_client_config.current.tenant_id
    object_id         = data.azurerm_client_config.current.object_id
  
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
