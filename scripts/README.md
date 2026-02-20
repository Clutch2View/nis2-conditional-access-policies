# Scripts

This directory contains helper PowerShell scripts for managing Conditional Access policies. These scripts are optional utilities — all policies can be deployed manually through the Entra admin center GUI.

## Available Scripts

| Script | Description |
|---|---|
| validate-policies.ps1 | Validates JSON policy files for correct schema, required fields, and common errors |
| export-current-policies.ps1 | Exports your current Conditional Access policies to JSON files for backup or comparison |

## Prerequisites

- **PowerShell 7+** (cross-platform)
- **Microsoft Graph PowerShell SDK**: `Install-Module Microsoft.Graph -Scope CurrentUser`
- **Appropriate permissions**: `Policy.Read.All` for export, `Policy.ReadWrite.ConditionalAccess` for management
- Global Administrator or Security Administrator role

## Important Notes

> ⚠️ **WARNING**: These scripts are provided as utilities. The primary deployment method is through the Entra admin center GUI. No PowerShell knowledge is required to deploy the policies.

> 💡 **TIP**: Run `validate-policies.ps1` before importing policies to catch any configuration errors.

## Usage

The scripts use interactive authentication — you will be prompted to sign in to your tenant.
