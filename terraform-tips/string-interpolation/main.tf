locals {
  split_string = "one,two,three"

  text1 = "one"
  text2 = "two"
  number1 = 42
  number2 = 2063

  json_value1 = <<EOF
{
  "database": {
    "connectionString": "connection value"
  },
  "title": "Some JSON"
}
EOF

  json_value2 = <<JSON
{
  "database": {
    "connectionString": "connection value"
  },
  "title": "Some JSON"
}
JSON
}

output "split-1" {
  value = "${split(",", local.split_string)}"
}

output "string-1" {
  value = "${local.text1}-${local.number2}"
}

output "string-2" {
  value = "${local.text1}${local.text2}"
}

output "json_value1" {
  value = local.json_value1
}

output "trim-test" {
    value = "${trim("==hello world==", "=")}"
}

output "trim-test-2" {
    value = "${trim("!?hello world!", "!?")}"
}