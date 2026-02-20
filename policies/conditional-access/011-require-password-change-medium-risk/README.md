# CA011: Require Password Change — Medium-Risk Users

## What This Policy Does

This policy requires users classified as **medium risk** by Entra ID Protection to complete MFA and change their password before continuing to access resources. Unlike high-risk users (blocked by CA010), medium-risk users can self-remediate by performing MFA verification and setting a new password.

This enables automatic incident response for potentially compromised accounts while minimizing disruption for users.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis and information system security |
| Article 21(2)(b) | Incident handling — automated remediation for medium-risk accounts |
| Article 21(2)(j) | Use of cryptography — forces credential rotation when compromise is suspected |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Replace the placeholder GUID before enabling. Self-Service Password Reset (SSPR) must be enabled for this policy to work.

---

## Prerequisites

- Microsoft Entra ID P2 license (included in M365 E5)
- Entra ID Protection enabled
- **Self-Service Password Reset (SSPR) enabled** for all users
- Password writeback configured (if using hybrid identity)
- Emergency Access Accounts group exists

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA011: Require Password Change — Medium-Risk Users`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **User risk**: Select **Medium**
   - **Grant**: Require **MFA** AND **Password change**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Normal user**: No impact.
- **Medium-risk user**: During their next sign-in, they are prompted to complete MFA, then immediately asked to change their password. After changing the password, their risk is automatically cleared and they can continue working.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA009 | High-risk sign-ins are blocked (more severe) |
| CA010 | High-risk users are fully blocked (more severe) |
| SSPR | Must be enabled for users to change their password inline |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users unable to change password | Ensure SSPR is enabled and the user is registered for SSPR |
| Hybrid users cannot change password | Enable password writeback in Entra Connect |
| Risk not clearing after password change | Allow up to 30 minutes for Identity Protection to re-evaluate risk |
| Users stuck in a loop | Ensure both MFA and SSPR registration are complete |

---

## 💡 Tips

- Ensure all users are registered for both MFA and SSPR.
- This policy uses the AND operator — both MFA and password change are required.
- Monitor the Identity Protection dashboard for medium-risk user trends.

---

## Related Policies

- **CA009**: Block High-Risk Sign-Ins
- **CA010**: Block High-Risk Users
