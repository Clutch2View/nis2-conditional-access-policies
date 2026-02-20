# CA003: Require MFA — All Administrators

## What This Policy Does
Requires MFA specifically for all administrator directory roles. This is a dedicated admin MFA policy separate from CA002 to ensure admin coverage even if the all-users policy is modified.

## NIS2 Mapping
**Article 21(2)(i)** — Human resources security, access control policies. **Article 21(2)(j)** — Multi-factor authentication.

## Admin Roles Included
Global Administrator, Security Administrator, Exchange Administrator, SharePoint Administrator, User Administrator, Helpdesk Administrator, Billing Administrator, Compliance Administrator, Conditional Access Administrator, Authentication Administrator, Privileged Role Administrator, Application Administrator, Cloud Application Administrator, Intune Administrator, Authentication Policy Administrator.

## Placeholder GUIDs
| Placeholder | Replace With |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | CA-EmergencyAccess group Object ID |

## End-User Experience
Administrators are prompted for MFA when signing in. This applies regardless of their device compliance status.
