# CA019: Restrict External/Guest Access

## What This Policy Does

This policy applies stricter controls to **external/guest users** (B2B collaboration guests, B2B direct connect users, and other external users). Guests must complete MFA on every access and have a shorter session duration (4 hours). This limits the exposure from external accounts that may not meet your organization's security standards.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(d) | Supply chain security — controls third-party access |
| Article 21(2)(a) | Risk analysis — applies tighter controls to external identities |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in excludeGroups) | Emergency Access Accounts group |
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in excludeApplications) | Apps that guests need without MFA (optional, remove if not needed) |

---

## Prerequisites

- Guest access policies configured in Entra ID External Identities
- MFA registration possible for guest users (via their home tenant or your tenant)

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA019: Restrict External/Guest Access`
   - **Users**: Include **Guest or external users** (all types), Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps** (optionally exclude specific apps)
   - **Grant**: Require **MFA**
   - **Session**: Sign-in frequency **4 hours**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Guest user**: Must complete MFA every 4 hours when accessing your resources.
- **Internal user**: No impact — this policy only targets guest/external users.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA002 | MFA baseline for all users covers internal users; this adds restrictions for guests |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Guests cannot complete MFA | Ensure their home tenant supports MFA or enable MFA registration in your tenant |
| Guests blocked from needed apps | Add the app to excludeApplications if necessary |
| 4-hour session too short | Adjust the sign-in frequency value to balance security and usability |

---

## Related Policies

- **CA014**: Require Terms of Use (consider requiring ToU for guests)
- **CA021**: Block Restricted Countries
