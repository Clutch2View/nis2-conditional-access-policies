# CA006: Require App Protection Policy — Android

## What This Policy Does

This policy requires Android devices to use apps that are protected by an Intune App Protection Policy before accessing Microsoft 365 resources. It mirrors CA005 (iOS) but targets the Android platform. Users must access corporate data through approved, managed apps such as Outlook, Teams, and OneDrive.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(d) | Supply chain security — ensures data is accessed only through protected applications |
| Article 21(2)(i) | Human resources security — protects corporate data on personal Android devices |
| Article 21(2)(j) | Cryptography and encryption — MAM policies enforce encryption of data at rest |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Replace the placeholder GUID with your actual Emergency Access Accounts group Object ID before enabling.

---

## Prerequisites

- Intune App Protection Policies configured for Android (see MAM002)
- Microsoft Authenticator or Intune Company Portal installed on Android devices
- Emergency Access Accounts group exists in Entra ID
- CA001–CA003 deployed

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA006: Require App Protection Policy — Android`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Device platforms**: Include **Android**
   - **Grant**: Select **Require approved client app** and **Require app protection policy** with operator **OR**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Using approved apps (Outlook, Teams, etc.)**: Seamless experience after initial app protection setup.
- **Using non-approved apps**: Blocked with a message directing the user to use an approved app.
- **First-time setup**: User installs Company Portal or Authenticator, then signs into the managed app. A one-time setup configures the app protection policy.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA001 | Legacy auth must be blocked first |
| CA002 | MFA baseline required |
| MAM002 | Android App Protection Policy must be configured in Intune |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users on non-Samsung Android devices having issues | Ensure Company Portal is installed even if not enrolling the device |
| App protection policy not applying | User must sign out and sign back in to the managed app |
| Android version too old | Check minimum OS version in your app protection policy |
| Work profile conflicts | If the device has a work profile, ensure MAM policies are compatible |

---

## 💡 Tips

- Android requires either **Company Portal** or **Microsoft Authenticator** to broker the app protection policy — ensure one is installed.
- Test in Report-only mode for 7+ days.
- Review Intune app protection status reports alongside CA sign-in logs.

---

## Related Policies

- **CA005**: Require App Protection for iOS/iPadOS
- **CA004**: Require Compliant Device for Windows/macOS
- **MAM002**: Android App Protection Policy
