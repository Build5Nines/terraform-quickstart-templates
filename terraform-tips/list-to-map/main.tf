// More information about converting a list
// to a map can be found here:
// https://build5nines.com/terraform-convert-list-to-map-of-objects-using-for-loop/

locals {
    # Add your list of property names here
    propList = ["firstName", "lastName", "website"]

    propMap = { 
        for prop in local.propList : 
            prop => { "type" = "string" }
    }
    // result:
    # {
    #     "firstName" = {
    #         "type" = "string"
    #     }
    #     "lastName" = {
    #         "type" = "string"
    #     }
    #     "website" = {
    #         "type" = "string"
    #     }
    # }
}
