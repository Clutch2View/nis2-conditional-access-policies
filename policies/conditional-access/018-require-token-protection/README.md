# CA018: Require Token Protection (Token Binding)

## What This Policy Does

This policy enables **token protection** (also called token binding), which cryptographically binds access tokens to the device that requested them. If an attacker steals a token and tries to replay it from a different device, the token will be rejected. This defends against token theft attacks, including adversary-in-the-middle (AiTM) attacks.

Currently, token protection is available for Windows devices accessing Office 365 via browser (Edge/Chrome).

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — mitigates token theft and replay attacks |
| Article 21(2)(j) | Use of cryptography — binds tokens cryptographically to devices |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Token protection is currently in preview and only supports Windows + browser scenarios. Do not apply to all platforms.

---

## Prerequisites

- Windows devices joined or registered to Entra ID
- Users accessing Office 365 via Edge or Chrome on Windows
- CA004 (compliant device policy) deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA018: Require Token Protection (Token Binding)`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **Office 365**
   - **Conditions** → **Device platforms**: Include **Windows**
   - **Conditions** → **Client apps**: **Browser**
   - **Session**: Enable **Require token protection for sign-in sessions**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Windows device with Edge/Chrome**: Transparent — tokens are bound to the device automatically.
- **Non-Windows device**: Not affected by this policy.
- **Token stolen and replayed**: The replay attempt is blocked.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA004 | Device must be registered/joined for token binding |
| CA016 | Sign-in frequency limits complement token protection |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Token protection not applying | Verify the device is Entra ID joined or registered and using a supported browser |
| Unsupported browser | Only Edge and Chrome support token binding. Firefox is not yet supported. |
| macOS/Linux devices | Token protection is currently Windows-only |

---

## Related Policies

- **CA016**: Sign-In Frequency
- **CA004**: Require Compliant Device for Windows/macOS
