# CA015: App-Enforced Restrictions — Unmanaged Devices

## What This Policy Does

This policy applies **app-enforced restrictions** when users access Office 365 from unmanaged (non-compliant) devices via a web browser. SharePoint Online and Exchange Online enforce limited web access — users can view but cannot download, print, or sync files. This provides a safe fallback for users who need to access data from personal or public computers.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(d) | Supply chain security — prevents data exfiltration from unmanaged devices |
| Article 21(2)(i) | Human resources security — limits access on personal devices |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

---

## Prerequisites

- SharePoint Online and Exchange Online configured to honor app-enforced restrictions
- In SharePoint admin center: enable "Control access from unmanaged devices"
- CA004 deployed (compliant device baseline)

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA015: App-Enforced Restrictions — Unmanaged Devices`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: Select **Office 365**
   - **Conditions** → **Client apps**: **Browser** only
   - **Conditions** → **Filter for devices**: Include where device.isCompliant -ne True
   - **Session**: Enable **Use app enforced restrictions**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Managed/compliant device**: Full access to SharePoint, Exchange, OneDrive.
- **Unmanaged device (browser)**: Limited web access — can view documents but cannot download, print, or sync. Download buttons are hidden or disabled.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA004 | Compliant device baseline must be defined |
| SharePoint admin settings | Must enable unmanaged device restrictions |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users can still download on unmanaged devices | Verify SharePoint admin center has app-enforced restrictions enabled |
| Policy not applying | Check the device filter rule syntax |
| Hybrid joined devices affected | Adjust the filter to also exclude ServerAD trust type |

---

## Related Policies

- **CA004**: Require Compliant Device for Windows/macOS
- **CA016**: Sign-In Frequency (session limits)
