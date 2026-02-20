# CA022: Restrict Access for Insider Risk Users

## What This Policy Does

This policy integrates with **Microsoft Purview Insider Risk Management** to apply app-enforced restrictions when a user's insider risk level is **elevated**. When Insider Risk Management flags a user (due to anomalous data exfiltration, policy violations, etc.), this Conditional Access policy automatically restricts their access — for example, preventing file downloads in SharePoint/OneDrive.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — automated response to insider threats |
| Article 21(2)(b) | Incident handling — dynamic access restrictions during investigations |
| Article 21(2)(i) | Human resources security — controls for risky insiders |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

---

## Prerequisites

- Microsoft Purview Insider Risk Management configured and active
- Adaptive Protection enabled in Insider Risk Management
- Insider Risk Management policies creating risk signals
- Microsoft 365 E5 license (required for Insider Risk Management)

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA022: Restrict Access for Insider Risk Users`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Insider risk**: Select **Elevated**
   - **Session**: Enable **Use app enforced restrictions**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Normal user**: No impact.
- **Elevated insider risk user**: Limited access — can view documents but cannot download, print, or sync. The user is not notified of their insider risk status.

---

## Dependencies

| Policy | Reason |
|---|---|
| Purview Insider Risk Management | Must be configured with Adaptive Protection |
| CA015 | Similar app-enforced restrictions pattern |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Policy not triggering | Ensure Adaptive Protection is enabled in Insider Risk Management |
| User restrictions not applying | Verify SharePoint/Exchange app-enforced restrictions are enabled |
| False positives | Tune Insider Risk Management policies to reduce noise |

---

## Related Policies

- **CA015**: App-Enforced Restrictions for Unmanaged Devices
- **CA009/CA010**: Identity Protection risk-based policies
