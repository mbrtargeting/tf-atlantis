# globally used locals
locals {
  # typical resource prefix
  prefix = "${var.nickname}-${var.acc_name}-${var.stage}"
  # camel case resource prefix
  camel_prefix = join("", [title(var.nickname), title(var.acc_name), title(var.stage)])
  # path resource prefix
  path_prefix = "/${var.nickname}/${var.acc_name}/${var.stage}/"
}
