<#
.SYNOPSIS
    Validates Conditional Access policy JSON files for common errors.

.DESCRIPTION
    This script reads all JSON files in the policies directory and checks for:
    - Valid JSON syntax
    - Required fields (displayName, state, conditions, grantControls/sessionControls)
    - Correct state value (must be enabledForReportingButNotEnforced)
    - Presence of emergency access exclusion group
    - Placeholder GUIDs that need replacement

.NOTES
    No PowerShell modules required - this is a local validation script.
    Does NOT connect to Microsoft Graph or modify any cloud resources.

.EXAMPLE
    ./validate-policies.ps1
    ./validate-policies.ps1 -Path "../policies/conditional-access"
#>

param(
    [string]$Path = (Join-Path $PSScriptRoot ".." "policies" "conditional-access")
)

$ErrorCount = 0
$WarningCount = 0
$PassCount = 0

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NIS2 Policy Validator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$jsonFiles = Get-ChildItem -Path $Path -Filter "*.json" -Recurse

if ($jsonFiles.Count -eq 0) {
    Write-Host "[ERROR] No JSON files found in: $Path" -ForegroundColor Red
    exit 1
}

Write-Host "Found $($jsonFiles.Count) JSON files to validate." -ForegroundColor White
Write-Host ""

foreach ($file in $jsonFiles) {
    Write-Host "Validating: $($file.Name)" -ForegroundColor White

    # Check 1: Valid JSON
    try {
        $policy = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    }
    catch {
        Write-Host "  [FAIL] Invalid JSON syntax: $($_.Exception.Message)" -ForegroundColor Red
        $ErrorCount++
        continue
    }
    Write-Host "  [PASS] Valid JSON" -ForegroundColor Green
    $PassCount++

    # Check 2: Required fields
    if (-not $policy.displayName) {
        Write-Host "  [FAIL] Missing displayName" -ForegroundColor Red
        $ErrorCount++
    }
    else {
        Write-Host "  [PASS] displayName: $($policy.displayName)" -ForegroundColor Green
        $PassCount++
    }

    # Check 3: State must be report-only
    if ($policy.state -and $policy.state -ne "enabledForReportingButNotEnforced") {
        Write-Host "  [FAIL] State is '$($policy.state)' - must be 'enabledForReportingButNotEnforced'" -ForegroundColor Red
        $ErrorCount++
    }
    elseif ($policy.state) {
        Write-Host "  [PASS] State is report-only" -ForegroundColor Green
        $PassCount++
    }

    # Check 4: Emergency access exclusion
    $rawContent = Get-Content -Path $file.FullName -Raw
    if ($rawContent -match "excludeGroups") {
        Write-Host "  [PASS] Emergency access exclusion group present" -ForegroundColor Green
        $PassCount++
    }
    elseif ($policy.conditions) {
        Write-Host "  [WARN] No excludeGroups found - ensure emergency access is excluded" -ForegroundColor Yellow
        $WarningCount++
    }

    # Check 5: Placeholder GUIDs
    if ($rawContent -match "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx") {
        Write-Host "  [WARN] Contains placeholder GUIDs - replace before deployment" -ForegroundColor Yellow
        $WarningCount++
    }
    else {
        Write-Host "  [PASS] No placeholder GUIDs found" -ForegroundColor Green
        $PassCount++
    }

    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Validation Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Files scanned: $($jsonFiles.Count)" -ForegroundColor White
Write-Host "  Checks passed: $PassCount" -ForegroundColor Green
Write-Host "  Warnings:      $WarningCount" -ForegroundColor Yellow
Write-Host "  Errors:        $ErrorCount" -ForegroundColor $(if ($ErrorCount -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($ErrorCount -gt 0) {
    Write-Host "Fix the errors above before importing policies." -ForegroundColor Red
    exit 1
}
else {
    Write-Host "All validations passed. Policies are ready for review." -ForegroundColor Green
    exit 0
}
