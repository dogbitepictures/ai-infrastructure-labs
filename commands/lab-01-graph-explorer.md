\# Lab 1 – Graph Explorer cheat sheet



All calls are read-only GETs in Graph Explorer. Consent for yourself only.



\## Who am I?

`GET https://graph.microsoft.com/v1.0/me?$select=displayName`

\- Permission: User.Read

\- At work: confirm which account you're signed in as

\- Errors: 401 = signed out; 403 = permission not consented



\## How many users?

`GET https://graph.microsoft.com/v1.0/users/$count` with header `ConsistencyLevel: eventual`

\- Permission: User.ReadBasic.All

\- At work: quick tenant size check

\- Errors: 400 = header missing; 403 = permission not consented



\## Which licences?

`GET https://graph.microsoft.com/v1.0/subscribedSkus`

\- Permission: LicenseAssignment.Read.All

\- At work: licence audits, spare seats, cost reviews

\- Key fields: skuPartNumber (name), consumedUnits (used)



\## Safety

Never paste tenant IDs, emails or tokens into GitHub or chat. Sign out when done.

