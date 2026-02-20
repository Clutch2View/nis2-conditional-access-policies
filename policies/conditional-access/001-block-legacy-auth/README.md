# CA001: Block Legacy Authentication — All Users

## What This Policy Does

Blocks all sign-in attempts that use legacy authentication protocols, including Exchange ActiveSync and other older clients. Legacy authentication does not support multi-factor authentication, making it a primary target for password spray and credential stuffing attacks.

## Why It Matters for NIS2

**Article 21(2)(a)** — Risk analysis and information system security policies. Legacy authentication is a well-known attack vector. Blocking it eliminates a significant risk to information system security.

## Policy Details

| Setting | Value |
|---|---|
| **Applies to** | All users |
| **Excludes** | CA-EmergencyAccess group |
| **Target apps** | All cloud apps |
| **Client app types** | Exchange ActiveSync, Other clients |
| **Grant control** | Block |
| **State** | Report-Only |

## Placeholder GUIDs to Replace

| Placeholder | Replace With |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (excludeGroups) | Your **CA-EmergencyAccess** group Object ID |

## How to Import

1. Go to **entra.microsoft.com**
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **New policy** → **Import**
4. Select `CA001-block-legacy-authentication.json`
5. Review the settings
6. Replace the placeholder GUID with your CA-EmergencyAccess group ID
7. Click **Save**

## What the End User Experiences

- Users with modern clients (Outlook desktop app, Outlook mobile, Teams, web browsers) are **not affected**
- Users with old email clients that use basic authentication will be blocked
- Common affected clients: Outlook 2010 and earlier, older mobile email apps, POP3/IMAP clients without OAuth
- Users should be directed to upgrade to modern clients

## Common Issues

| Issue | Solution |
|---|---|
| Old email clients stop working | Upgrade to modern clients that support OAuth/modern auth |
| Printers or scanners that send email | Use SMTP client submission with modern auth, or exclude specific service accounts |
| Legacy line-of-business apps | Evaluate whether the app can be updated, or create a scoped exception |

## Dependencies

None. This is typically the first policy to deploy as it has the least disruptive impact on users with modern clients.
