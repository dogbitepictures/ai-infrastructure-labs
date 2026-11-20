
# Lab 2 – Graph PowerShell cheat sheet

All commands are read-only. Run PowerShell as a normal user, not as administrator.

## Setup (once per PC)
| Command | What it does | Notes |
|---|---|---|
| `Install-Module Microsoft.Graph.Authentication -Scope CurrentUser` | Installs the Graph sign-in module for your user only | Answer Y/A to NuGet and PSGallery prompts |
| `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` | Lets your user run downloaded, signed modules | Affects your account only |
| `Get-ChildItem $mod -Recurse \| Unblock-File` | Marks downloaded module files as trusted | Set `$mod` to the module folder first |

## Sign in and out
| Command | Least permission | At work |
|---|---|---|
| `Connect-MgGraph -Scopes "User.Read" -NoWelcome` | User.Read | Confirm who you're signed in as |
| `Connect-MgGraph -Scopes "User.ReadBasic.All","LicenseAssignment.Read.All" -NoWelcome` | Read basic users + licences | Tenant health check |
| `Get-MgContext` | n/a | Shows current account and scopes (don't share the output) |
| `Disconnect-MgGraph \| Out-Null` | n/a | Sign out without printing IDs |

## Read-only checks
**Who am I?**
`Invoke-MgGraphRequest -Uri 'v1.0/me?$select=displayName'`
Expected: your display name.

**How many users?**
`Invoke-MgGraphRequest -Uri 'v1.0/users/$count' -Headers @{ConsistencyLevel='eventual'}`
Expected: a number (lab tenant: 3).

**Which licences, and how many used?**
`(Invoke-MgGraphRequest -Uri 'v1.0/subscribedSkus').value | ForEach-Object { $_.skuPartNumber + ' used ' + $_.consumedUnits }`
Expected: e.g. `O365_BUSINESS_ESSENTIALS used 1`.

## Common errors
| Error | Meaning | Fix |
|---|---|---|
| `CouldNotAutoloadMatchingModule` | Module blocked (often a synced Documents folder) | RemoteSigned + Unblock-File, then reopen PowerShell |
| `Unexpected token '-Recurse'` | Command line incomplete | Check the command starts with `Get-ChildItem` |
| `Authentication needed. Please call Connect-MgGraph` | Not signed in | Run Connect-MgGraph again |
| `400` mentioning ConsistencyLevel | Missing header on `$count` | Add `-Headers @{ConsistencyLevel='eventual'}` |
| `403 Forbidden` | Scope not granted | Reconnect with the right `-Scopes` |

## Safety habits
- Use single quotes around URIs containing `$`.
- Never paste tenant IDs, account IDs, emails or tokens into GitHub or chat.
