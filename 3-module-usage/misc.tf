provider "external" {
  version = "1.2"
}

data "external" "user_id" {
  program = ["sh", "../scripts/fetch-value.sh", "user_id"]
}

locals {
  user_id = data.external.user_id.result.response
}
