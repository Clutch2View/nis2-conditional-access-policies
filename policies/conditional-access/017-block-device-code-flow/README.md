# CA017: Block Device Code Authentication Flow

## What This Policy Does

This policy blocks the **device code authentication flow**, which is a common attack vector used in phishing campaigns. In a device code phishing attack, an attacker tricks a user into entering a code at microsoft.com/devicelogin, which grants the attacker access to the user's account. By blocking this flow entirely, you eliminate this attack vector.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — eliminates a known phishing attack vector |
| Article 21(2)(b) | Incident handling — proactive prevention of device code phishing |
| Article 21(2)(g) | Basic cyber hygiene — blocks abuse-prone authentication flow |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: If your organization uses devices that rely on device code flow (meeting room displays, IoT devices), you must create exceptions for those service accounts before enabling this policy.

---

## Prerequisites

- Identify any legitimate device code flow usage (conference room displays, etc.)
- Create a dedicated exclusion group for those service accounts if needed
- Emergency Access Accounts group exists

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA017: Block Device Code Authentication Flow`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Authentication flows**: Select **Device code flow**
   - **Grant**: **Block access**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Normal sign-in**: No impact at all.
- **Device code flow attempt**: The user sees an error when trying to complete device code authentication at microsoft.com/devicelogin.
- **Phishing attempt**: The phishing attack fails because the flow is blocked.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA001 | Legacy auth blocked first |
| CA002 | MFA baseline in place |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Teams Rooms / meeting displays cannot authenticate | Exclude the service accounts used for these devices |
| Azure CLI authentication fails | Users should use interactive browser auth instead of device code |
| PowerShell scripts using device code flow | Update scripts to use interactive or certificate-based auth |

---

## 💡 Tips

- Device code phishing is one of the most common modern attack vectors — blocking this is highly recommended.
- Review sign-in logs for device code flow usage before enabling.
- Exceptions should be minimal and tightly scoped to specific service accounts.

---

## Related Policies

- **CA001**: Block Legacy Authentication
- **CA012**: Require Phishing-Resistant MFA for Admins
