# CA004: Require Compliant Device — Windows & macOS

## What This Policy Does

This policy requires that **Windows and macOS devices must be Intune-compliant** before they can access any Microsoft 365 resources. Since the organization uses MDM (Intune enrollment) for Windows and macOS, this ensures all corporate-owned devices meet your compliance baselines (encryption enabled, firewall on, OS up to date, etc.) before granting access.

If a device is not enrolled in Intune or fails a compliance check, the user is blocked from accessing cloud apps on that device.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(d) | Supply chain security — ensures only managed, compliant endpoints access corporate resources |
| Article 21(2)(i) | Human resources security — device compliance enforces security baselines on endpoints |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group — must be excluded from this policy |

> ⚠️ **WARNING**: Replace the placeholder GUID with your actual Emergency Access Accounts group Object ID before enabling this policy.

---

## Prerequisites

- Microsoft Intune is configured and devices are enrolled
- Device compliance policies exist for both Windows and macOS in Intune
- Emergency Access Accounts group exists in Entra ID
- CA001–CA003 are already deployed

---

## Import Instructions

1. Open the **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy from template** or **+ New policy**
4. If creating manually, configure:
   - **Name**: `CA004: Require Compliant Device — Windows & macOS`
   - **Users**: Include **All users**, Exclude your **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Device platforms**: Include **Windows** and **macOS**
   - **Grant**: Require **device to be marked as compliant**
5. Set the policy to **Report-only** mode first
6. Click **Create**

Alternatively, import the JSON file using Microsoft Graph API or the Conditional Access API.

---

## What Does This Look Like for the End User?

- **Compliant device**: No change — the user signs in normally.
- **Non-compliant device**: The user sees a message saying their device does not meet the organization's compliance requirements. They are directed to the Company Portal app to resolve compliance issues.
- **Unenrolled device**: The user is blocked and prompted to enroll their Windows or macOS device into Intune.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA001 | Legacy auth must be blocked first — legacy clients cannot evaluate device compliance |
| CA002 | MFA baseline ensures users have strong authentication before device compliance is checked |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users on personal Windows/macOS devices are blocked | This is expected — only Intune-enrolled compliant devices are allowed. Personal devices should use browser-based access with app-enforced restrictions (CA015). |
| Newly enrolled devices are blocked immediately | Intune compliance evaluation can take up to 30 minutes after enrollment. Ask the user to wait and retry. |
| macOS devices showing non-compliant | Verify that macOS compliance policies are configured in Intune and the device has checked in recently. |
| Break-glass accounts locked out | Ensure the Emergency Access group is properly excluded. |

---

## 💡 Tips

- Test this policy in **Report-only** mode for at least 7 days before enforcing.
- Review the **Conditional Access insights and reporting** workbook to see which devices would be blocked.
- Ensure your Intune compliance policies have a grace period so newly enrolled devices are not immediately blocked.

---

## Related Policies

- **CA005**: Require App Protection for iOS (handles iOS devices via MAM instead of MDM)
- **CA008**: Require Compliant Device for Admin Portals (stricter requirement for admin access)
- **CA015**: App-Enforced Restrictions for Unmanaged Devices (fallback for personal devices)
