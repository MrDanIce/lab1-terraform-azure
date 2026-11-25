# Troubleshooting

Real errors only. Copy the message when it happens.

| Date | Error | Cause | Fix |
|---|---|---|---|
| 2026-11-25 | Standard_B2ats_v2 unusable in westus2 and eastus2: restriction NotAvailableForSubscription (caught by SKU query before apply) | The SKU API lists the size as restricted for this free trial subscription | Switched to Standard_B2pts_v2 (Arm, no restriction in westus2) and the server-arm64 Ubuntu image |
| 2026-11-25 | Federated credential subject did not match the repository's OIDC subject prefix (caught before the first CI run) | The repository uses GitHub's immutable subject format, which includes numeric owner and repo IDs | Changed github_repo to owner@ownerID/name@repoID |
| 2026-11-25 | Squash merging a pull request published the account's public profile email as the commit author, although local commits used the noreply address | GitHub writes the squash commit itself, using the account's email setting, not the local git config | Enabled private email in GitHub settings and passed --author-email with the noreply address on later merges |
