# Conditional Access Policies

This directory contains 22 Conditional Access policies plus the emergency access documentation (CA000). Each policy is in its own folder with a JSON file and a README explaining the policy.

## Import Order

Import policies in this recommended order:

| Order | Folder | Policy | Dependencies |
|---|---|---|---|
| — | 000-emergency-access | Emergency Access Accounts (documentation only) | Create accounts first |
| 1 | 001-block-legacy-auth | Block Legacy Authentication | None |
| 2 | 002-require-mfa-all-users | Require MFA — All Users | None |
| 3 | 003-require-mfa-admins | Require MFA — Admins | None |
| 4 | 004-require-compliant-device | Require Compliant Device — Win/macOS | Intune compliance policies |
| 5 | 005-require-app-protection-ios | Require App Protection — iOS/iPadOS | MAM001 deployed |
| 6 | 006-require-app-protection-android | Require App Protection — Android | MAM002 deployed |
| 7 | 007-block-unknown-platforms | Block Unknown Platforms | None |
| 8 | 008-require-compliant-device-admins | Require Compliant Device — Admin Portals | Intune compliance policies |
| 9 | 009-block-high-risk-sign-ins | Block High-Risk Sign-Ins | Entra ID Protection (P2) |
| 10 | 010-block-high-risk-users | Block High-Risk Users | Entra ID Protection (P2) |
| 11 | 011-require-password-change-medium-risk | Password Change — Medium Risk | Entra ID Protection (P2) |
| 12 | 012-require-phishing-resistant-mfa-admins | Phishing-Resistant MFA — Admins | FIDO2/WHfB deployed |
| 13 | 013-block-directory-sync-non-trusted | Restrict Directory Sync | Named locations |
| 14 | 014-require-tos-acceptance | Terms of Use | ToU document created |
| 15 | 015-session-controls-unmanaged-devices | App-Enforced Restrictions | None |
| 16 | 016-sign-in-frequency | Sign-In Frequency | None |
| 17 | 017-block-device-code-flow | Block Device Code Flow | None |
| 18 | 018-require-token-protection | Token Protection | Windows devices |
| 19 | 019-restrict-guest-access | Restrict Guest Access | None |
| 20 | 020-global-secure-access-traffic | Require Compliant Network (GSA) | GSA configured |
| 21 | 021-block-countries | Block Restricted Countries | Blocked countries location |
| 22 | 022-insider-risk-conditional-access | Insider Risk Restrictions | Purview configured |

## How to Import

1. Go to **entra.microsoft.com**
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **New policy** → **Import** (or the Import button)
4. Select the JSON file from the appropriate folder
5. Review and save
6. Update placeholder GUIDs with your actual group IDs

## Placeholder GUIDs

All policies use `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` for group references. After importing each policy, replace the placeholder with your actual group Object ID. The most common placeholder is the **CA-EmergencyAccess** group in the exclude list.

## Safety

> ⚠️ Every policy is in **Report-Only** mode. Never change to **On** without testing first.
