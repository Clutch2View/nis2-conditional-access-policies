# MAM Guide — Mobile Application Management for iOS/iPadOS

This guide explains how the MAM (Mobile Application Management) policies work for iPhones and iPads in this configuration. The key design principle: **users can access corporate data on their personal iPhones and iPads without enrolling their device in MDM (Intune device management).**

## How MAM Works

MAM protects corporate data at the **application level** rather than the device level:

- Users install Microsoft apps (Outlook, Teams, etc.) from the App Store as normal
- When they sign in with their corporate account, the app protection policy activates
- Corporate data within the app is encrypted and protected
- Personal data on the device is untouched — IT cannot see or wipe personal content
- If the user leaves the organization, only the corporate data inside managed apps is wiped

## MAM vs MDM

| Feature | MAM (App Management) | MDM (Device Management) |
|---|---|---|
| Device enrollment required | No | Yes |
| IT can see personal apps | No | Depends on config |
| IT can wipe entire device | No | Yes |
| IT can wipe corporate data only | Yes | Yes |
| Data protection in managed apps | Yes | Yes |
| Device-level security policies | No | Yes |
| Used for in this repo | iOS/iPadOS | Windows/macOS |

## Deploying MAM Policies

### Step 1: Create the iOS App Protection Policy (MAM001)

1. Sign in to **[intune.microsoft.com](https://intune.microsoft.com)**
2. Navigate to **Apps** → **App protection policies**
3. Click **Create policy** → **iOS/iPadOS**
4. **Name**: `MAM001: iOS/iPadOS App Protection Policy`

**Apps tab:**
- Select **Target policy to**: All Microsoft Apps (or select specific apps)
- Recommended apps: Outlook, Teams, Word, Excel, PowerPoint, OneDrive, SharePoint, OneNote, To Do, Planner, Edge

**Data protection tab:**
- Backup org data to iTunes/iCloud: **Block**
- Send org data to other apps: **Policy managed apps**
- Receive data from other apps: **All apps**
- Restrict cut, copy, and paste between other apps: **Policy managed apps with paste in**
- Third-party keyboards: **Block**
- Encrypt org data: **Require**
- Sync policy managed app data with native apps: **Block**
- Printing org data: **Block**

**Access requirements tab:**
- PIN for access: **Require**
- PIN type: **Numeric**
- Minimum PIN length: **6**
- Touch ID instead of PIN: **Allow**
- Face ID instead of PIN: **Allow**
- Override biometrics with PIN after timeout: **Require**, 30 minutes
- PIN reset after number of days: **Yes**, 365 days
- Work or school account credentials: **Require**

**Conditional launch tab:**
- Jailbroken/rooted devices: **Block access**
- Min OS version: **16.0** (adjust to your org's minimum)
- Max allowed device threat level: **Secured** (requires MTD connector)
- Disabled account: **Block access**
- Offline grace period (block access): **30 minutes**
- Offline grace period (wipe data): **720 minutes**

**Assignments tab:**
- Include: **All users** or your MAM user group
- Exclude: Service accounts if needed

### Step 2: Create the Android App Protection Policy (MAM002)

Follow the same steps but select **Android** as the platform. Key differences:

- Screen capture: **Block**
- Approved keyboards: **Require** (add Microsoft SwiftKey and other approved keyboards)
- Min OS version: **13.0**

### Step 3: Create the iOS App Configuration Policy (MAM004)

1. In Intune admin center, go to **Apps** → **App configuration policies**
2. Click **Create** → **Managed apps**
3. Select **Microsoft Outlook** as the target app
4. Configure these settings:
   - Focused Inbox: **Enabled**
   - Block external images: **Enabled**
   - Default email account configuration as per your org

### Step 4: Link CA Policies to MAM

After MAM policies are deployed and assigned:

1. Import **CA005** (Require App Protection — iOS/iPadOS)
2. Import **CA006** (Require App Protection — Android)
3. These CA policies will require that an app protection policy is applied before granting access

## What the End User Experiences

### First-Time Setup on iPhone

1. User downloads Microsoft Outlook (or Teams, etc.) from the App Store
2. User signs in with their corporate email address
3. User completes MFA enrollment if not done already
4. Outlook prompts: "Your organization requires app protection"
5. User sets a 6-digit app PIN (or enables Face ID/Touch ID)
6. Corporate email starts syncing
7. The user's personal apps and data are completely unaffected

### Daily Use

- Opening managed apps may require Face ID/Touch ID or PIN
- Copy/paste from corporate apps to personal apps is restricted
- Attachments can only be saved to OneDrive (not personal iCloud)
- The user experience within the app is otherwise normal

### If a User Leaves the Organization

- IT performs a selective wipe from Intune
- Only corporate data inside managed apps is removed
- Personal photos, apps, and data are untouched
- The user retains full control of their personal device

## Troubleshooting MAM

| Issue | Solution |
|---|---|
| User not prompted for app protection | Ensure MAM policy is assigned and user has licensed correctly. Allow up to 30 minutes for policy to apply. |
| App PIN keeps resetting | Check PIN reset policy settings. Ensure biometric override timeout is configured. |
| Cannot copy text to personal apps | Working as intended — this is the data protection policy preventing data leakage. |
| App crashes on launch | Verify minimum OS version. Update the app to latest version. |
| Selective wipe not working | Ensure device has internet connectivity. Wipe may take up to 24 hours. |

## NIS2 Relevance

MAM policies address several NIS2 Article 21 requirements:

- **Article 21(2)(a)**: Information system security through app-level protection
- **Article 21(2)(d)**: Supply chain security by controlling data on personal devices
- **Article 21(2)(h)**: Encryption of organizational data within managed applications
