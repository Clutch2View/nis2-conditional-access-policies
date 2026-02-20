# Getting Started Guide

This guide walks you through importing the NIS2 Conditional Access policies into your Microsoft Entra ID tenant. No PowerShell or scripting experience is needed — everything is done through the admin portal GUI.

## Prerequisites Checklist

Before you begin, confirm the following:

- [ ] **Microsoft 365 E5 license** (or Microsoft Entra ID P2 + Intune P2 + Microsoft Defender for Cloud Apps)
- [ ] **Global Administrator** or **Conditional Access Administrator** role assigned to your account
- [ ] **Emergency access accounts** created (at least 2) — see [Microsoft's best practices](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access)
- [ ] **Required security groups** created in Entra ID — see [groups/required-groups.md](../groups/required-groups.md)
- [ ] **Named locations** configured — see [named-locations/README.md](../named-locations/README.md)
- [ ] **Microsoft Intune** configured and licensed
- [ ] **Global Secure Access** enabled in tenant (for GSA policies only)

For detailed prerequisites, see [PREREQUISITES.md](PREREQUISITES.md).

## Step 1: Create Required Groups

Before importing any policies, you must create the security groups that the policies reference. See [groups/required-groups.md](../groups/required-groups.md) for the complete list.

At minimum, you need:

1. **CA-EmergencyAccess** — Add your break-glass accounts to this group
2. **CA-ServiceAccounts** — Add any service/app accounts
3. **CA-DirectorySyncAccounts** — Add your Entra Connect sync accounts

## Step 2: Create Named Locations

Navigate to **Microsoft Entra admin center** → **Protection** → **Conditional Access** → **Named locations**.

Create the following locations:

1. **USA Corporate Offices** — Add your US office IP ranges
2. **EMEA Corporate Offices** — Add your EMEA office IP ranges
3. **APAC Corporate Offices** — Add your APAC office IP ranges
4. **Trusted IP Ranges** — Add VPN egress and other trusted IPs
5. **Blocked Countries** — Create a countries/regions location with your blocked countries

See [named-locations/README.md](../named-locations/README.md) for detailed instructions and templates.

## Step 3: Import Conditional Access Policies

### How to Import a Policy

1. Sign in to **[entra.microsoft.com](https://entra.microsoft.com)**
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **New policy** in the toolbar
4. Click **Import** (you may see this as an option in the New policy dropdown or as a separate button)
5. Select the JSON file from this repository
6. Review the imported policy settings
7. The policy will import in **Report-Only** mode
8. Click **Save**

> ⚠️ **IMPORTANT**: After importing each policy, you must update the placeholder GUIDs with your actual group IDs. The placeholder `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` appears wherever a group reference is needed.

### How to Update Placeholder GUIDs

1. After importing a policy, click on it to edit
2. Under **Users** → **Exclude**, you will see the placeholder GUID
3. Click the exclude group field and search for your actual group (e.g., "CA-EmergencyAccess")
4. Remove the placeholder and add your real group
5. Repeat for any other placeholder GUIDs in the policy
6. Click **Save**

### Recommended Import Order

Import policies in this order to minimize conflicts and dependencies:

| Order | Policy | Notes |
|---|---|---|
| 1 | CA001 — Block Legacy Auth | Low impact, blocks only legacy protocols |
| 2 | CA002 — Require MFA All Users | High impact — test thoroughly in Report-Only |
| 3 | CA003 — Require MFA Admins | Admin-specific MFA |
| 4 | CA004 — Compliant Device Win/macOS | Requires Intune compliance policies configured |
| 5 | CA005 — App Protection iOS | Requires MAM policies deployed first |
| 6 | CA006 — App Protection Android | Requires MAM policies deployed first |
| 7 | CA007 — Block Unknown Platforms | Blocks non-standard platforms |
| 8 | CA008 — Compliant Device Admin Portals | Admin portal protection |
| 9 | CA009 — Block High-Risk Sign-Ins | Requires Entra ID Protection (P2) |
| 10 | CA010 — Block High-Risk Users | Requires Entra ID Protection (P2) |
| 11 | CA011 — Password Change Medium Risk | Requires Entra ID Protection (P2) |
| 12 | CA012 — Phishing-Resistant MFA Admins | Requires FIDO2/WHfB deployed |
| 13 | CA013 — Restrict Directory Sync | Requires named locations configured |
| 14 | CA014 — Terms of Use | Requires Terms of Use document created |
| 15 | CA015 — App-Enforced Restrictions | Session controls |
| 16 | CA016 — Sign-In Frequency | Session controls |
| 17 | CA017 — Block Device Code Flow | Blocks device code auth |
| 18 | CA018 — Token Protection | Preview feature — verify availability |
| 19 | CA019 — Restrict Guest Access | Guest/external controls |
| 20 | CA020 — Require Compliant Network GSA | Requires Global Secure Access configured |
| 21 | CA021 — Block Restricted Countries | Requires blocked countries named location |
| 22 | CA022 — Insider Risk | Requires Microsoft Purview configured |

## Step 4: Deploy MAM Policies

Before the CA005 and CA006 policies will work, you must deploy the App Protection policies:

1. Sign in to **[intune.microsoft.com](https://intune.microsoft.com)** (or endpoint.microsoft.com)
2. Navigate to **Apps** → **App protection policies**
3. Click **Create policy** → **iOS/iPadOS** (for MAM001)
4. Configure settings as documented in [policies/app-protection-mam/README.md](../policies/app-protection-mam/README.md)
5. Repeat for Android (MAM002) and Windows (MAM003)

See [MAM-GUIDE.md](MAM-GUIDE.md) for the complete deployment walkthrough.

## Step 5: Test in Report-Only Mode

Every policy imports in **Report-Only** mode. This means:

- The policy evaluates against all sign-ins but does **not** enforce any controls
- Results appear in the **sign-in logs** under the **Conditional Access** tab
- You can see what **would have happened** without actually blocking anyone

### How to Review Report-Only Results

1. Go to **Entra admin center** → **Identity** → **Monitoring & health** → **Sign-in logs**
2. Click on any sign-in entry
3. Select the **Conditional Access** tab
4. Look for your imported policies — they will show as **Report-only** with a result of:
   - **Report-only: Success** — The policy would have granted access
   - **Report-only: Failure** — The policy would have blocked access
   - **Report-only: Not applied** — The policy conditions were not met

### Using the What If Tool

1. Go to **Protection** → **Conditional Access** → **What If**
2. Select a user, app, and device conditions
3. Click **What If**
4. Review which policies would apply and their outcomes

## Step 6: Enable Policies

Once you are confident a policy works correctly in Report-Only mode:

1. Edit the policy
2. Under **Enable policy**, change from **Report-only** to **On**
3. Click **Save**

> ⚠️ **WARNING**: Enable policies one at a time. Wait at least 24-48 hours between enabling policies to monitor for issues.

> 💡 **TIP**: Start with CA001 (Block Legacy Auth) as it typically has the least disruptive impact. Save CA002 (Require MFA All Users) for later as it has the broadest impact.

## Rollback Procedure

If a policy causes issues after being enabled:

1. Navigate to the policy in **Conditional Access** → **Policies**
2. Change the state back to **Report-only** (or **Off**)
3. Click **Save**
4. Changes take effect within minutes

If you are locked out entirely, use your **emergency access accounts** to sign in and disable the problematic policy.

## Next Steps

- Review [POLICY-OVERVIEW.md](POLICY-OVERVIEW.md) for a summary of every policy
- Read [REGIONAL-CONSIDERATIONS.md](REGIONAL-CONSIDERATIONS.md) for region-specific guidance
- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) if you encounter issues
- See [CUSTOMIZATION.md](CUSTOMIZATION.md) for how to tailor policies to your organization
