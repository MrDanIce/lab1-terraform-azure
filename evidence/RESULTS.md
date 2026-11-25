# Results

Redact subscription IDs, tenant IDs and emails before saving output or screenshots.

| Date | Environment | Command | Key output | Number to quote |
|---|---|---|---|---|
| 2026-11-25 | macOS 26.5.2, Apple M1, Terraform 1.17.2, azurerm ~> 4.40.0 | terraform fmt -check -recursive; init -backend=false and validate in bootstrap and infra; gitleaks dir | fmt exit 0; validate: 'Success! The configuration is valid.' (both); gitleaks: no leaks found | 2 of 2 configurations valid (nothing applied) |
| 2026-11-25 | same, azurerm 4.40.0, Azure free trial westus2 | terraform apply (bootstrap) | evidence/bootstrap-apply.txt | 10 resources added, 0 changed, 0 destroyed |
| 2026-11-25 | same | terraform apply (bootstrap, OIDC subject fix) | Apply complete | 0 added, 1 changed, 0 destroyed |
| 2026-11-25 | same, Standard_B2pts_v2 | terraform apply (infra) | evidence/infra-apply.txt | 9 resources added, 0 changed, 0 destroyed |
| 2026-11-25 | GitHub Actions | pull request 1 checks | check (bootstrap), check (infra), plan all pass | 3 of 3 checks passing, 1 pull request |
| 2026-11-25 | Standard_B2pts_v2, westus2 | az vm run-command CPU load, 12 minutes | evidence/alert-test.txt | Alert fired once; 446 seconds from load command to alert start |
| 2026-11-25 | Azure portal | Monitor > Alerts | evidence/cpu-alert.png | alert-lab1-cpu shown as Fired |
| 2026-11-25 | GitHub Actions | pull requests 1 to 3 | check (bootstrap), check (infra), plan all pass on each | 3 of 3 pull requests passing |
