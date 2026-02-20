# App Protection (MAM) Policies

This directory contains **Mobile Application Management (MAM)** policies for Intune. These policies protect corporate data within managed apps without requiring device enrollment (MDM).

## Organization Profile

- **iOS/iPadOS**: MAM only (no MDM enrollment) — personal iPhones and iPads
- **Android**: MAM for personal devices
- **Windows**: MAM via Edge browser (supplements MDM)

## Policy Inventory

| File | Platform | Description |
|---|---|---|
| MAM001-ios-ipados-app-protection.json | iOS/iPadOS | Comprehensive app protection with data protection, access, and conditional launch settings |
| MAM002-android-app-protection.json | Android | Mirror of iOS policy with Android-specific settings |
| MAM003-windows-app-protection.json | Windows | Edge browser protection for unmanaged scenarios |
| MAM004-ios-app-configuration-outlook.json | iOS/iPadOS | Outlook-specific app configuration policy |

## How MAM Works

1. User installs a managed app (e.g., Outlook) from the app store
2. User signs in with their corporate account
3. Intune detects the sign-in and applies the app protection policy
4. Corporate data is encrypted and contained within the managed app
5. Copy/paste, file sharing, and backup are restricted to managed apps only

## NIS2 Alignment

All MAM policies map to NIS2 Article 21(2)(d) (supply chain security), 21(2)(i) (human resources security), and 21(2)(j) (cryptography and encryption).

## Deployment Order

1. Deploy MAM001 (iOS) and MAM002 (Android) first
2. Deploy MAM004 (Outlook configuration) alongside MAM001
3. Deploy MAM003 (Windows) after MDM policies are stable
4. Enable CA005 and CA006 to enforce app protection via Conditional Access

## Important Notes

> ⚠️ **WARNING**: MAM policies must be deployed BEFORE enabling CA005/CA006. If Conditional Access requires app protection but no MAM policy exists, users will be blocked.

> 💡 **TIP**: MAM policies take effect when the user signs into a managed app. There may be a delay of up to 30 minutes for policy to apply on first sign-in.
