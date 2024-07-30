# Gitlab secrets
resource "random_password" "atlantis_gitlab_secret" {
  count   = var.gitlab_username != "" ? 1 : 0
  length  = 24
  special = false
  numeric = true
  upper   = true
  lower   = true
}

resource "aws_secretsmanager_secret" "atlantis_gitlab_secret" {
  count                   = var.gitlab_username != "" ? 1 : 0
  name                    = "atlantis-gitlab-secret"
  description             = "GitLab secret for atlantis"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "atlantis_gitlab_secret" {
  count         = var.gitlab_username != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlantis_gitlab_secret[0].id
  secret_string = random_password.atlantis_gitlab_secret[0].result
}

resource "aws_secretsmanager_secret" "atlantis_gitlab_token" {
  count                   = var.gitlab_username != "" ? 1 : 0
  name                    = "atlantis-gitlab-token"
  description             = "GitLab token for atlantis"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "atlantis_gitlab_token" {
  count         = var.gitlab_username != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlantis_gitlab_token[0].id
  secret_string = "to_be_replaced"

  lifecycle {
    ignore_changes = [secret_string]

  }
}

data "aws_secretsmanager_secret_version" "atlantis_gitlab_token" {
  count     = var.gitlab_username != "" ? 1 : 0
  secret_id = aws_secretsmanager_secret.atlantis_gitlab_token[0].id
}

# Github secrets
resource "random_password" "atlantis_gh_secret" {
  count   = var.github_username != "" ? 1 : 0
  length  = 24
  special = false
  numeric = true
  upper   = true
  lower   = true
}

resource "aws_secretsmanager_secret" "atlantis_gh_secret" {
  count                   = var.github_username != "" ? 1 : 0
  name                    = "atlantis-github-secret"
  description             = "Github secret for atlantis"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "atlantis_gh_secret" {
  count         = var.github_username != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlantis_gh_secret[0].id
  secret_string = random_password.atlantis_gh_secret[0].result
}

resource "aws_secretsmanager_secret" "atlantis_gh_token" {
  count                   = var.github_username != "" ? 1 : 0
  name                    = "atlantis-github-token"
  description             = "Giihub token for atlantis"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "atlantis_gh_token" {
  count         = var.github_username != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlantis_gh_token[0].id
  secret_string = "to_be_replaced"
}
