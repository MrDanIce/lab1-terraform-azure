# Troubleshooting

Real errors only. Copy the message when it happens.

| Date | Error | Cause | Fix |
|---|---|---|---|
| 2026-11-25 | Standard_B2ats_v2 unusable in westus2 and eastus2: restriction NotAvailableForSubscription (caught by SKU query before apply) | The SKU API lists the size as restricted for this free trial subscription | Switched to Standard_B2pts_v2 (Arm, no restriction in westus2) and the server-arm64 Ubuntu image |
