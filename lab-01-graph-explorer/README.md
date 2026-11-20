# Lab 1 — Microsoft Graph Explorer: tenant read-only checks

## What I did
Signed into Graph Explorer on my own Microsoft 365 lab tenant and ran three read-only (GET) queries:
- /me returned 200 OK with my profile (permission: User.Read)
- /users/$count with the ConsistencyLevel: eventual header returned 3 users, which matched the Entra admin center (permission: User.ReadBasic.All)
- /subscribedSkus returned 1 licence, O365_BUSINESS_ESSENTIALS (Microsoft 365 Business Basic), with 1 seat in use (permission: LicenseAssignment.Read.All)

## Why it matters
Microsoft Graph is the API that scripts, automation and AI tools such as Copilot use to read Microsoft 365 data. Running least-privilege, read-only queries is the safe first step toward automated user audits and licence reporting.

## What I learned
- GET means read; I made no changes.
- I consented only to the minimum permission for each query.
- Counting needs a special request header (ConsistencyLevel: eventual).
- Checking one tool against another (Graph vs Entra) catches mistakes.
- Tenant IDs, emails and tokens stay out of shared evidence.
