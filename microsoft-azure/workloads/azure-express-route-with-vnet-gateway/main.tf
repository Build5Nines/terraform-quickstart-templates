locals {
    # Azure region to deploy to
    azure_region = "eastus"

    # define the Azure resource names
    resource_name_prefix= "E1-B59-PRD-NET" # {region}-{org}-{env}-{app}
    resource_group_name = "${resource_name_prefix}-rg"


    # set of common tags to apply to all Azure resources
    tags= {
        source = "terraform"
    }
}
