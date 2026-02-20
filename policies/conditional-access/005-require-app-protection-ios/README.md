# CA005: Require App Protection Policy — iOS/iPadOS

## What This Policy Does

This is a **key Mobile Application Management (MAM) policy**. Since the organization uses **MAM-only (no MDM enrollment)** for iPhones and iPads, this policy ensures that users can only access Microsoft 365 data through apps that are protected by an Intune App Protection Policy.

Instead of requiring device enrollment, this policy requires that the app itself is an **approved client app** with an **app protection policy** applied. This means corporate data stays protected inside managed apps (like Outlook, Teams, OneDrive) even on personal devices.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(d) | Supply chain security — ensures data is only accessed through protected applications |
| Article 21(2)(i) | Human resources security — protects corporate data on personal mobile devices |
| Article 21(2)(j) | Cryptography and encryption — MAM policies enforce encryption of corporate data at rest |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group — must be excluded from this policy |

> ⚠️ **WARNING**: Replace the placeholder GUID with your actual Emergency Access Accounts group Object ID before enabling this policy.

---

## Prerequisites

- Intune App Protection Policies are configured for iOS/iPadOS (see MAM001)
- Microsoft Authenticator is deployed to users
- Emergency Access Accounts group exists in Entra ID
- Users have been communicated about using approved apps only

---

## Import Instructions

1. Open the **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA005: Require App Protection Policy — iOS/iPadOS`
   - **Users**: Include **All users**, Exclude your **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Device platforms**: Include **iOS**
   - **Grant**: Select **Require approved client app** and **Require app protection policy** with operator **OR**
5. Set the policy to **Report-only** mode first
6. Click **Create**

---

## What Does This Look Like for the End User?

- **Using Outlook, Teams, OneDrive on iPhone/iPad**: No disruption — user is prompted once to set up app protection (PIN, biometrics). After that, access is seamless.
- **Using native iOS Mail or non-approved apps**: The user is blocked from accessing corporate email/data. They see a message directing them to install an approved app like Outlook.
- **First-time setup**: The user may be asked to install Microsoft Authenticator and register the app with Intune. This is a one-time process.

---

## Dependencies

| Policy | Reason |
|---|---|
| CA001 | Legacy auth must be blocked — legacy clients cannot enforce app protection |
| CA002 | MFA ensures strong authentication before app protection check |
| MAM001 | The Intune App Protection Policy for iOS must exist before this CA policy is effective |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Users cannot access email on native iOS Mail | Expected behavior — direct users to install Microsoft Outlook from the App Store |
| App protection policy not detected | Ensure the user has signed into the app with their corporate account and the Intune Company Portal or Authenticator app is installed |
| Users on older iOS versions blocked | Check minimum OS version requirements in your app protection policy |
| Multiple accounts on device causing conflicts | Ensure users sign into managed apps with their corporate account first |

---

## 💡 Tips

- This policy works **without MDM enrollment** — perfect for BYOD iPhone/iPad scenarios.
- Pair this with **MAM001** (iOS App Protection Policy) for complete data protection.
- Users only need Microsoft Authenticator installed — no Company Portal enrollment required for MAM-only.
- Test in Report-only mode for 7+ days and review the sign-in logs.

---

## Related Policies

- **CA004**: Require Compliant Device for Windows/macOS (MDM approach for desktops)
- **CA006**: Require App Protection for Android (same MAM approach for Android)
- **MAM001**: iOS/iPadOS App Protection Policy (the Intune policy that defines data protection settings)
