# CA013: Restrict Directory Sync — Trusted Locations Only

## What This Policy Does

This policy restricts the **Directory Synchronization Accounts** role to only authenticate from **trusted named locations**. This ensures that Entra Connect (Azure AD Connect) sync operations can only occur from your known datacenter or on-premises server IPs, preventing an attacker from syncing a rogue directory from an unauthorized location.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — protects the directory sync pipeline |
| Article 21(2)(d) | Supply chain security — prevents unauthorized directory synchronization |
| Article 21(2)(e) | Security in network and information systems acquisition |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |
| `d29b2b05-8046-44ba-8758-1e26182fcf32` | Directory Synchronization Accounts role template ID (built-in, do not change) |

> ⚠️ **WARNING**: You must configure trusted named locations (NL001, NL005) with your Entra Connect server IPs before enabling this policy.

---

## Prerequisites

- Named locations configured with Entra Connect server IPs
- Entra Connect is operational and syncing from known IPs
- Emergency Access Accounts group exists

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA013: Restrict Directory Sync — Trusted Locations Only`
   - **Users**: Include role **Directory Synchronization Accounts**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Locations**: Include **Any location**, Exclude **All trusted locations**
   - **Grant**: **Block access**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Entra Connect from trusted location**: Sync works normally, no impact.
- **Sync attempt from untrusted location**: Blocked. The sync will fail and an alert should be generated.
- **Regular users**: No impact — this policy only targets Directory Sync accounts.

---

## Dependencies

| Policy | Reason |
|---|---|
| NL001/NL005 | Trusted named locations must be configured with sync server IPs |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Entra Connect sync fails after enabling | Verify the sync server IP is in a trusted named location |
| New sync server cannot connect | Add the new server IP to trusted named locations first |
| Sync works in Report-only but fails when enabled | Double-check the location configuration matches the actual egress IP |

---

## Related Policies

- **NL001**: Corporate Offices named location
- **NL005**: Datacenter Ranges named location
