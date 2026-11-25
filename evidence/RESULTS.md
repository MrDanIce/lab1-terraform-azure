# Results

Redact subscription IDs, tenant IDs and emails before saving output or screenshots.

| Date | Environment | Command | Key output | Number to quote |
|---|---|---|---|---|
| 2026-11-25 | macOS 26.5.2, Apple M1, Terraform 1.17.2, azurerm ~> 4.40.0 | terraform fmt -check -recursive; init -backend=false and validate in bootstrap and infra; gitleaks dir | fmt exit 0; validate: 'Success! The configuration is valid.' (both); gitleaks: no leaks found | 2 of 2 configurations valid (nothing applied) |
| 2026-11-25 | same, azurerm 4.40.0, Azure free trial westus2 | terraform apply (bootstrap) | evidence/bootstrap-apply.txt | 10 resources added, 0 changed, 0 destroyed |
