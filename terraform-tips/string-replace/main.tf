locals {
    example_string = "The quick brown fox jumps over the lazy dog"
}

output "simple-replace" {
    value = "${replace("hello world", "world", "terraform")}"
}

output "regex-replace-number" {
    value = "${replace("hello world 123", "/[0-9]/", "X")}"
}

output "regex-replace-vowels" {
  value = replace(local.example_string, "/[aeiou]/", "*")
}

output "regex-replace-non-alphanumeric" {
  value = replace("Hello! This is a test string #123$%^", "/[^a-zA-Z0-9]/", "")
}

output "regex-replace-captured-strings" {
  value = replace("John Doe (johndoe@example.com)", "/([a-zA-Z]+) ([a-zA-Z]+) \\(([^)]+)\\)/", "$2, $1 - Email: $3")
}

output "regex-replace-email-domain" {
  value = replace("chris@build5nines.com", "/^[^@]+@([^@]+)$/", "$1")
}

output "regex-replace-remove-whitespace" {
  value = replace("This is a test", "/[\\s]+/", "")
}

output "regex-replace-url-protocol" {
  value = replace("https://build5nines.com", "/http[s|]?:\\/\\//", "")
}

output "regex-replace-remove-html-tags" {
  value = replace("<p>Hello, <b>world</b>!</p>", "/<[^>]+>/", "")
}

output "regex-replace-normalize-phone-number" {
  value = replace("+1 (555) 123-4567", "/[^\\d]/", "")
}