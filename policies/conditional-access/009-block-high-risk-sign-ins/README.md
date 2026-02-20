# CA009: Block High-Risk Sign-Ins

## What This Policy Does

This policy uses **Microsoft Entra ID Protection** to automatically block sign-in attempts that are classified as **high risk**. High-risk sign-ins include those from anonymous IP addresses, impossible travel scenarios, malware-linked IP addresses, and other suspicious indicators detected by Microsoft's threat intelligence.

When a sign-in is flagged as high risk, the user is immediately blocked rather than being allowed to attempt MFA or other remediation.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis and information system security |
| Article 21(2)(b) | Incident handling — automatic blocking of high-risk events |
| Article 21(2)(d) | Supply chain security — prevents compromised credential usage |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Replace the placeholder GUID. Emergency access accounts must always be excluded from blocking policies.

---

## Prerequisites

- Microsoft Entra ID P2 license (included in M365 E5)
- Entra ID Protection enabled and configured
- Emergency Access Accounts group exists
- CA001-CA003 deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA009: Block High-Risk Sign-Ins`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Sign-in risk**: Select **High**
   - **Grant**: **Block access**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Normal sign-in**: No impact whatsoever.
- **High-risk sign-in detected**: The user sees a block page explaining that access has been denied due to a risky sign-in attempt. They should contact IT support to verify the sign-in attempt.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA002 | MFA baseline should be in place first |
| CA010 | Pair with high-risk user policy for comprehensive Identity Protection |
| CA011 | Medium-risk users get password change requirement instead of block |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Legitimate users blocked after traveling | Check the sign-in logs — impossible travel may trigger. Users should contact IT to dismiss the risk. |
| Too many false positives | Review Identity Protection risk detections and tune detection policies |
| VPN triggering high risk | Add VPN egress IPs as trusted named locations (NL002) |
| Users cannot self-remediate | High-risk sign-ins are blocked, not remediated. Admin must dismiss the risk in Identity Protection. |

---

## 💡 Tips

- Run in Report-only mode for at least 14 days to catch false positives.
- Monitor the Identity Protection dashboard for risk detection patterns.
- Configure trusted named locations (NL001, NL002) to reduce false positives from known IPs.

---

## Related Policies

- **CA010**: Block High-Risk Users
- **CA011**: Require Password Change for Medium-Risk Users
- **NL001/NL002**: Named Locations (reduce false positives)
