# CA016: Sign-In Frequency — 12-Hour Session Limit

## What This Policy Does

This policy limits user sessions to **12 hours** before requiring re-authentication. It also disables persistent browser sessions, ensuring users cannot stay signed in indefinitely. After 12 hours, users must re-authenticate with MFA, reducing the window of opportunity for session hijacking or token theft.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — limits session duration to reduce risk exposure |
| Article 21(2)(j) | Use of cryptography — forces regular token refresh |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

---

## Prerequisites

- CA002 (MFA for all users) deployed
- Users registered for MFA

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA016: Sign-In Frequency — 12-Hour Session Limit`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Session** → **Sign-in frequency**: 12 hours
   - **Session** → **Persistent browser session**: Never persistent
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **During the 12-hour window**: Normal access with no prompts.
- **After 12 hours**: User is prompted to re-authenticate (MFA). Takes about 30 seconds.
- **Browser sessions**: Never persist — closing the browser ends the session.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA002 | MFA must be configured for re-authentication prompts |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users complaining about frequent MFA prompts | 12 hours is the recommended balance between security and usability. Adjust if necessary but do not exceed 24 hours. |
| Sessions ending mid-work | Users should save work regularly. The re-auth prompt allows them to continue after authenticating. |
| Mobile apps requiring frequent sign-in | Mobile apps handle token refresh differently — this primarily affects browser sessions. |

---

## 💡 Tips

- 12 hours aligns with a typical work day plus buffer.
- Consider setting different frequencies for admins (shorter) vs. regular users.
- Persistent browser sessions are disabled to prevent unattended session abuse.

---

## Related Policies

- **CA015**: App-Enforced Restrictions for Unmanaged Devices
- **CA018**: Require Token Protection
