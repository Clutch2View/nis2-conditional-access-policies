# CA008: Require Compliant Device — Admin Portals

## What This Policy Does

This policy requires administrators to use Intune-compliant devices when accessing Microsoft admin portals (Azure Portal, Microsoft 365 Admin Center, Exchange Admin Center, etc.). Admin accounts are high-value targets, so this policy adds an extra layer of protection beyond standard MFA by ensuring admin tasks are performed from managed, compliant devices only.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — protects high-privilege admin access with device compliance |
| Article 21(2)(i) | Human resources security — ensures admin operations occur on secured endpoints |
| Article 21(2)(g) | Basic cyber hygiene and security training — admins must use compliant devices |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

The `includeRoles` section uses well-known directory role template IDs for common admin roles (Global Administrator, Security Administrator, Exchange Administrator, etc.).

> ⚠️ **WARNING**: Replace the placeholder GUID with your actual Emergency Access Accounts group Object ID.

---

## Prerequisites

- Intune device compliance policies for Windows and macOS
- Admin accounts have Intune-enrolled compliant devices
- Emergency Access Accounts group exists
- CA003 (MFA for admins) deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA008: Require Compliant Device — Admin Portals`
   - **Users**: Include **Directory roles** (Global Admin, Security Admin, Exchange Admin, etc.), Exclude **Emergency Access Accounts** group
   - **Target resources**: Select **Microsoft Admin Portals**
   - **Conditions** → **Device platforms**: All platforms
   - **Grant**: Require **device to be marked as compliant**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Admin on compliant device**: No disruption — admin portal access works normally.
- **Admin on non-compliant device**: Blocked from accessing admin portals. Must switch to a compliant device.
- **Admin on personal device**: Cannot access admin portals. Must use a corporate Intune-enrolled device.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA003 | MFA for admins must be in place first |
| CA004 | Device compliance baseline for Windows/macOS |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Admin locked out of all portals | Check that their device is enrolled and compliant in Intune |
| New admin cannot access portal | Ensure their device is enrolled and compliance check has completed |
| Compliance status shows pending | Wait up to 30 minutes for Intune sync, or force a sync from Company Portal |

---

## 💡 Tips

- This policy specifically targets admin portals, not all cloud apps.
- Combine with CA012 (phishing-resistant MFA for admins) for defense-in-depth.
- Ensure all admin accounts have dedicated compliant devices.

---

## Related Policies

- **CA003**: Require MFA for Admins
- **CA004**: Require Compliant Device for Windows/macOS
- **CA012**: Require Phishing-Resistant MFA for Admins
