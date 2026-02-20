<#
.SYNOPSIS
    Exports current Conditional Access policies from your tenant to JSON files.

.DESCRIPTION
    Connects to Microsoft Graph and exports all Conditional Access policies
    to individual JSON files. Useful for backup, comparison with the template
    policies, or migration between tenants.

.NOTES
    Requires the Microsoft Graph PowerShell SDK.
    Install with: Install-Module Microsoft.Graph -Scope CurrentUser
    Required permissions: Policy.Read.All

.EXAMPLE
    ./export-current-policies.ps1
    ./export-current-policies.ps1 -OutputPath "./exported-policies"
#>

param(
    [string]$OutputPath = (Join-Path $PSScriptRoot ".." "exported-policies")
)

# Ensure output directory exists
if (-not (Test-Path -Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    Write-Host "Created output directory: $OutputPath" -ForegroundColor Green
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NIS2 Policy Exporter" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Connect to Microsoft Graph
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor White
try {
    Connect-MgGraph -Scopes "Policy.Read.All" -ErrorAction Stop
    Write-Host "Connected successfully." -ForegroundColor Green
}
catch {
    Write-Host "[ERROR] Failed to connect to Microsoft Graph: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Ensure the Microsoft Graph PowerShell SDK is installed:" -ForegroundColor Yellow
    Write-Host "  Install-Module Microsoft.Graph -Scope CurrentUser" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Export policies
Write-Host "Retrieving Conditional Access policies..." -ForegroundColor White

try {
    $policies = Get-MgIdentityConditionalAccessPolicy -All -ErrorAction Stop
}
catch {
    Write-Host "[ERROR] Failed to retrieve policies: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

if ($policies.Count -eq 0) {
    Write-Host "No Conditional Access policies found in this tenant." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($policies.Count) policies. Exporting..." -ForegroundColor White
Write-Host ""

$exportCount = 0

foreach ($policy in $policies) {
    $safeName = $policy.DisplayName -replace '[^a-zA-Z0-9-]', '-'
    $safeName = $safeName -replace '-+', '-'
    $safeName = $safeName.Trim('-')
    $fileName = "$safeName.json"
    $filePath = Join-Path $OutputPath $fileName

    $policy | ConvertTo-Json -Depth 10 | Out-File -FilePath $filePath -Encoding utf8

    Write-Host "  Exported: $($policy.DisplayName)" -ForegroundColor Green
    Write-Host "    -> $fileName" -ForegroundColor Gray
    $exportCount++
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Export Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Policies exported: $exportCount" -ForegroundColor Green
Write-Host "  Output directory:  $OutputPath" -ForegroundColor White
Write-Host ""
Write-Host "Review the exported files and compare with the NIS2 templates." -ForegroundColor White

# Disconnect
Disconnect-MgGraph | Out-Null
Write-Host "Disconnected from Microsoft Graph." -ForegroundColor Gray
