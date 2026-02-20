# CA010: Block High-Risk Users

## What This Policy Does

This policy uses **Microsoft Entra ID Protection** to block access for users whose accounts are classified as **high risk**. Unlike CA009 (which evaluates sign-in risk in real time), this policy evaluates the overall **user risk level** — an aggregate score based on leaked credentials, threat intelligence, and anomalous behavior over time.

When a user's risk level is high, all their sign-in attempts are blocked until an administrator reviews and remediates the risk.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis and information system security |
| Article 21(2)(b) | Incident handling — blocks compromised accounts automatically |
| Article 21(2)(j) | Use of cryptography and encryption — protects against credential compromise |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Replace the placeholder GUID. Emergency access accounts MUST be excluded from this policy.

---

## Prerequisites

- Microsoft Entra ID P2 license (included in M365 E5)
- Entra ID Protection enabled
- Emergency Access Accounts group exists
- CA009 (Block High-Risk Sign-Ins) deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA010: Block High-Risk Users`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **User risk**: Select **High**
   - **Grant**: **Block access**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Normal user (no risk)**: No impact.
- **High-risk user**: Completely blocked from all cloud apps. The user sees a block page and must contact IT/helpdesk. An admin must review the risk in Identity Protection and either confirm the compromise or dismiss the risk.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA009 | Block high-risk sign-ins complements this user-risk policy |
| CA011 | Medium-risk users get password change instead of full block |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| User flagged as high risk due to leaked credentials | Admin must review in Identity Protection, confirm or dismiss, and user must change password |
| Too many users flagged | Review risk detection sources — consider deploying SSPR to allow self-remediation |
| Legitimate user blocked | Admin can dismiss the risk in Identity Protection → Risky users |

---

## 💡 Tips

- Monitor the **Risky users** report in Identity Protection regularly.
- Consider enabling Self-Service Password Reset (SSPR) so medium-risk users can self-remediate (handled by CA011).
- High-risk users should always require admin intervention — do not lower this to self-remediation.

---

## Related Policies

- **CA009**: Block High-Risk Sign-Ins
- **CA011**: Require Password Change for Medium-Risk Users
