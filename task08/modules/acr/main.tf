resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.name}-build-task"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "task08/application/Dockerfile"
    context_path         = "https://github.com/apujanyan/epm-08.git#main"
    context_access_token = var.git_pat
    image_names          = ["${var.docker_image_name}:latest"]
  }

  source_trigger {
    name           = "source_trigger"
    events         = ["commit"]
    repository_url = "https://github.com/apujanyan/epm-08.git"
    source_type    = "Github"

    authentication {
      token      = var.git_pat
      token_type = "PAT"
    }
  }

  tags = var.tags

  depends_on = [azurerm_container_registry.this]
}

resource "azurerm_container_registry_task_schedule_run_now" "run_task" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id

  depends_on = [azurerm_container_registry_task.build_task]
}