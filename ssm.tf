resource "aws_ssm_parameter" "atlantis_gitlab_username" {
  count       = var.gitlab_username != "" ? 1 : 0
  name        = "${local.path_prefix}atlantis/gitlab/username"
  description = "Atlantis gitlab username"
  type        = "String"
  value       = var.gitlab_username
}

resource "aws_ssm_parameter" "atlantis_gh_username" {
  count       = var.github_username != "" ? 1 : 0
  name        = "${local.path_prefix}atlantis/github/username"
  description = "Atlantis github username"
  type        = "String"
  value       = var.github_username
}

resource "aws_ssm_parameter" "atlantis_repo_list" {
  name        = "${local.path_prefix}atlantis/allowed-repo-list"
  description = "Atlantis repo whitelist"
  type        = "String"
  value       = join(", ", var.repo_list)
}

# Atlantis WEB secret
resource "random_password" "atlantis_web_password" {
  length  = 24
  special = false
  numeric = true
  upper   = true
  lower   = true
}

resource "aws_ssm_parameter" "atlantis_web_password" {
  name        = "${local.path_prefix}atlantis/web/password"
  description = "Atlantis web password"
  type        = "SecureString"
  value       = random_password.atlantis_web_password.result
}
