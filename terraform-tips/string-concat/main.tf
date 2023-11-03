// More information about string concatenation
// can be found at these links too:
// https://build5nines.com/how-to-perform-simple-string-concatenation-in-terraform/
// https://build5nines.com/terraform-convert-string-to-list-join-function/

locals {
    firstName = "Chris"
    lastName = "Pietschmann"
    subdomain = "learn"
    website = "Build5Nines.com"

    // regular concatenation
    learnWebsite = "${local.subdomain}.build5nines.com"
    //result: "learn.build5nines.com"
    
    // regular concatenation
    fullName1 = "${local.firstName} ${local.lastName}"
    // result: "Chris Pietschmann"

    // using 'join' function
    fullName2 = join(" ", [local.firstName, local.lastName])
    // result: "Chris Pietschmann"

    // Concatenate list to comma delimited string
    itemList = ["a", "b", "c", "d"]
    listString = join(", ", local.itemList)
    // result: "a, b, c, d"
}