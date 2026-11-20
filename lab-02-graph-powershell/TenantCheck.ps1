# TenantCheck.ps1 - read-only tenant health check
Connect-MgGraph -Scopes "User.Read","User.ReadBasic.All","LicenseAssignment.Read.All" -NoWelcome

$me = Invoke-MgGraphRequest -Uri 'v1.0/me?$select=displayName'
Write-Host "Signed in as: $($me.displayName)"

$count = Invoke-MgGraphRequest -Uri 'v1.0/users/$count' -Headers @{ConsistencyLevel='eventual'}
Write-Host "Users in tenant: $count"

Write-Host "Licences:"
(Invoke-MgGraphRequest -Uri 'v1.0/subscribedSkus').value | ForEach-Object {
    Write-Host "  $($_.skuPartNumber) - used $($_.consumedUnits)"
}

Disconnect-MgGraph | Out-Null
Write-Host "Done - signed out."
