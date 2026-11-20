# Lab 2 – Microsoft Graph PowerShell (read-only)

## Goal
Repeat the Lab 1 Graph Explorer checks from PowerShell so they can be scripted and repeated.

## Why it matters
Clicking works for one tenant once. Scripts let you run the same health check on any tenant, any day, and keep the output.

## What I did
1. Checked PowerShell basics: `$PSVersionTable.PSVersion` (5.1), `Get-Date`, `Get-Command -Verb Get | Measure-Object`.
2. Installed `Microsoft.Graph.Authentication` for my user only (`-Scope CurrentUser`, no admin).
3. Fixed a module load error caused by a cloud-synced Documents folder: set `RemoteSigned` for CurrentUser and ran `Unblock-File` on the module.
4. Connected with least privilege and ran read-only checks:
   - `/me` with `User.Read`
   - `/users/$count` with `User.ReadBasic.All` → 3 users
   - `/subscribedSkus` with `LicenseAssignment.Read.All` → 1 Business Basic licence, 1 seat used
5. Signed out with `Disconnect-MgGraph | Out-Null` so IDs aren't shown on screen.

## What I learned
- Scopes are requested per sign-in; ask only for what the task needs.
- "Authentication needed" means the session is closed, so reconnect.
- Single quotes stop PowerShell treating `$select` / `$count` as variables.
- Keep tenant IDs, account IDs and emails out of screenshots and commits.
