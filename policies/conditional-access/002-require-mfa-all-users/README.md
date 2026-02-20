# CA002: Require MFA — All Users

## What This Policy Does
Requires multi-factor authentication for all users accessing any cloud application. This is the foundational MFA policy.

## NIS2 Mapping
**Article 21(2)(j)** — Use of multi-factor authentication or continuous authentication solutions.

## Policy Details
| Setting | Value |
|---|---|
| **Applies to** | All users |
| **Excludes** | CA-EmergencyAccess group, CA-ServiceAccounts group |
| **Target apps** | All cloud apps |
| **Grant control** | Require MFA |
| **State** | Report-Only |

## Placeholder GUIDs
| Placeholder | Replace With |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | CA-EmergencyAccess group Object ID |
| `yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy` | CA-ServiceAccounts group Object ID |

## End-User Experience
Users will be prompted to complete MFA (Authenticator app, phone call, SMS, or FIDO2 key) when signing in. After completing MFA, access is granted per the sign-in frequency settings.

## Common Issues
| Issue | Solution |
|---|---|
| Users not enrolled in MFA | Direct them to aka.ms/mfasetup to register |
| Service accounts blocked | Add to CA-ServiceAccounts exclude group |
| Too many MFA prompts | Check CA016 sign-in frequency settings |

## Dependencies
None, but ensure users have registered MFA methods before enabling this policy.
