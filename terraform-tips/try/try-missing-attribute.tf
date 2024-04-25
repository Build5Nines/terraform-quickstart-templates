
locals {
    env_data = jsondecode("{\"site\": \"build5nines.com\"}")
    //env_data = jsondecode("{\"environment\": \"Development\"}")
}

output "environment" {
  value = "${try(local.env_data.environment, "Production")}"
}