# Groups

This directory documents the Entra ID security groups required for Conditional Access policies to function properly.

## Why Groups Matter

Conditional Access policies reference groups for exclusions (emergency access), targeting (specific user populations), and assignments (MAM policies). These groups must exist in your Entra ID tenant before importing any policies.

## Files

| File | Description |
|---|---|
| required-groups.md | Complete list of all required groups with naming conventions and setup instructions |

## Quick Start

1. Review `required-groups.md` for the full list of required groups
2. Create the groups in Entra ID
3. Note the Object IDs for each group
4. Replace placeholder GUIDs (`xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`) in all policy files with actual Object IDs
5. Begin deploying policies

> ⚠️ **WARNING**: The Emergency Access Accounts group is the most critical. It must be created FIRST and populated with break-glass accounts before any blocking policies are enabled.
