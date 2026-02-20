# CA012: Require Phishing-Resistant MFA — Admins

## What This Policy Does

This policy requires administrators to use **phishing-resistant MFA** methods — specifically FIDO2 security keys, Windows Hello for Business, or certificate-based authentication. Standard MFA methods like push notifications and SMS are not sufficient for this policy.

This is a critical defense against adversary-in-the-middle (AiTM) phishing attacks that can intercept traditional MFA tokens.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — highest security for highest-privilege accounts |
| Article 21(2)(j) | Use of cryptography — phishing-resistant MFA uses cryptographic authentication |
| Article 21(2)(g) | Basic cyber hygiene practices and security training |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |
| `00000000-0000-0000-0000-000000000004` | Built-in Phishing-Resistant MFA authentication strength (do not change) |

The `includeRoles` values are well-known directory role template IDs for admin roles.

> ⚠️ **WARNING**: Ensure all admins have registered phishing-resistant MFA methods before enabling this policy. Admins without FIDO2 keys or Windows Hello will be locked out.

---

## Prerequisites

- FIDO2 security keys distributed to all admins, OR Windows Hello for Business configured
- Phishing-resistant MFA methods registered for all targeted admin accounts
- Emergency Access Accounts group exists (with FIDO2 keys)
- CA003 (MFA for admins) already deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA012: Require Phishing-Resistant MFA — Admins`
   - **Users**: Include **Directory roles** (admin roles), Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Grant**: Require **authentication strength** → Select **Phishing-resistant MFA**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Admin with FIDO2 key**: Prompted to tap their security key during sign-in. Seamless experience.
- **Admin with Windows Hello**: Uses biometric or PIN on their compliant device.
- **Admin without phishing-resistant method**: Blocked and directed to register a compliant MFA method.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA003 | Standard MFA for admins as a baseline |
| CA008 | Compliant device requirement for admin portals |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Admin locked out | Verify they have a FIDO2 key or Windows Hello registered in their authentication methods |
| FIDO2 key not recognized | Check browser compatibility — use Edge or Chrome. Firefox has limited FIDO2 support. |
| Authentication strength not available | This is a built-in strength in Entra ID — ensure your tenant is up to date |

---

## 💡 Tips

- Order FIDO2 security keys for all admins before deploying this policy.
- Each admin should register at least two FIDO2 keys (primary + backup).
- Test thoroughly in Report-only mode — this policy can lock out admins.

---

## Related Policies

- **CA003**: Require MFA for Admins (standard MFA baseline)
- **CA008**: Require Compliant Device for Admin Portals
