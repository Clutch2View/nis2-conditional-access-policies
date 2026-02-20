# CA007: Block Access from Unknown/Unsupported Platforms

## What This Policy Does

This policy blocks access to all cloud apps from any device platform that is not explicitly supported by the organization. The supported platforms are: Windows, macOS, iOS, Android, and Linux. Any other platform (such as ChromeOS, custom user agents, or spoofed platforms) is denied access.

This reduces the attack surface by ensuring only known, manageable platforms can access corporate resources.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis and information system security — reduces attack surface by limiting platforms |
| Article 21(2)(d) | Supply chain security — prevents access from unvetted device types |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Replace the placeholder GUID before enabling. Emergency access accounts must be excluded.

---

## Prerequisites

- CA004, CA005, CA006 deployed (to cover Windows, macOS, iOS, Android)
- Emergency Access Accounts group exists

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA007: Block Access from Unknown/Unsupported Platforms`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Device platforms**: Include **Any device**, Exclude **Android, iOS, Windows, macOS, Linux**
   - **Grant**: **Block access**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Users on supported platforms**: No impact at all.
- **Users on unsupported platforms (ChromeOS, etc.)**: Blocked with a message indicating the platform is not supported. They need to switch to a supported device.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA004 | Windows/macOS must have a compliant device policy |
| CA005/CA006 | iOS and Android must have app protection policies |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Linux users unexpectedly blocked | Linux is in the exclude list — ensure the platform detection is working correctly. Check sign-in logs for platform details. |
| Users with obscure browsers blocked | Some browsers report unusual user agents. Check the sign-in log for the device platform. |
| Legitimate ChromeOS users blocked | If ChromeOS is needed, add it to the exclude list and create a separate policy for it. |

---

## 💡 Tips

- Review sign-in logs in Report-only mode to identify any legitimate platforms you may need to allow.
- This policy catches attackers using unusual or spoofed device platforms.
- Consider adding Linux to the block list if your organization does not use Linux.

---

## Related Policies

- **CA004**: Require Compliant Device for Windows/macOS
- **CA005/CA006**: App Protection for mobile platforms
- **CA021**: Block Restricted Countries (geographic blocking)
