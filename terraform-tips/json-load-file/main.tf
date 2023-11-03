// More information about loading a json file into
// Terraform can be found here:
// https://build5nines.com/terraform-how-to-work-with-json-jsondecode-jsonencode-tfvars-json/

locals {
    // load 'data.json' file and decode it to a TF object
    json_data = jsondecode(file("${path.module}/data.json"))
}

// output the "environment" value from the JSON file
output json_environment {
    value = local.json_data.environment
}

// output the "website" value from the JSON file
output json_website {
    value = local.json_data.website
}