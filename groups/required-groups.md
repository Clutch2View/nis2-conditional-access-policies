# Required Entra ID Security Groups

This document lists all security groups that must be created in Microsoft Entra ID before deploying the Conditional Access policies.

## Critical Groups

### 1. Emergency Access Accounts (Break-Glass)

- **Suggested Name**: `SG-CA-EmergencyAccess`
- **Type**: Security group (Assigned membership)
- **Purpose**: Excluded from ALL blocking and granting policies to prevent total lockout
- **Members**: 2 dedicated break-glass accounts (cloud-only, no MFA, with FIDO2 keys)
- **Used By**: Every CA policy (CA001-CA022)

> ⚠️ **WARNING**: This is the most critical group. Create it FIRST. If all policies are enabled without this exclusion, you risk locking out your entire tenant.

### 2. MAM Users — iOS

- **Suggested Name**: `SG-MAM-iOS-Users`
- **Type**: Security group (Dynamic or Assigned)
- **Purpose**: Target group for iOS/iPadOS MAM policies
- **Members**: All users with iPhones/iPads
- **Used By**: MAM001, MAM004

### 3. MAM Users — Android

- **Suggested Name**: `SG-MAM-Android-Users`
- **Type**: Security group (Dynamic or Assigned)
- **Purpose**: Target group for Android MAM policies
- **Members**: All users with Android devices
- **Used By**: MAM002

### 4. MAM Users — Windows

- **Suggested Name**: `SG-MAM-Windows-Users`
- **Type**: Security group (Dynamic or Assigned)
- **Purpose**: Target group for Windows MAM (Edge browser) policies
- **Members**: All users who may access from unmanaged Windows devices
- **Used By**: MAM003

### 5. CA Policy Exclusions

- **Suggested Name**: `SG-CA-PolicyExclusions`
- **Type**: Security group (Assigned)
- **Purpose**: Temporary exclusion group for users who need to be excluded from specific policies during troubleshooting or migration
- **Members**: Added/removed as needed
- **Used By**: Optional — add to any CA policy as needed

### 6. Device Code Flow Exceptions

- **Suggested Name**: `SG-CA-DeviceCodeFlowAllowed`
- **Type**: Security group (Assigned)
- **Purpose**: Service accounts that legitimately need device code flow (Teams Rooms, etc.)
- **Members**: Service accounts for meeting room displays and IoT devices
- **Used By**: CA017

## Group Creation Steps

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Identity** → **Groups** → **All groups**
3. Click **+ New group**
4. Set **Group type** to **Security**
5. Enter the group name and description
6. Set **Membership type** to **Assigned** (or **Dynamic** for MAM groups)
7. Click **Create**
8. Note the **Object ID** from the group overview page
9. Replace `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` in policy files with the Object ID

## Dynamic Group Rules (Optional)

For MAM user groups, you can use dynamic membership rules based on device platform:

**iOS Users**: `(user.assignedPlans -any (assignedPlan.servicePlanId -eq "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -and assignedPlan.capabilityStatus -eq "Enabled"))`

**All Licensed Users**: `(user.accountEnabled -eq true) and (user.assignedLicenses -ne null)`

> 💡 **TIP**: Start with assigned groups for simplicity. Move to dynamic groups once your deployment is stable.
