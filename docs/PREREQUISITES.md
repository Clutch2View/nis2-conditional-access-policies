# Prerequisites

Complete this checklist before importing any policies from this repository.

## Licensing Requirements

You need **one** of the following license combinations:

**Option A — Microsoft 365 E5** (recommended, includes everything)

**Option B — Component licenses:**
- Microsoft Entra ID P2
- Microsoft Intune Plan 2
- Microsoft Defender for Cloud Apps
- Microsoft Purview (for insider risk policies)

> 💡 **TIP**: You can verify your licenses in the Microsoft 365 admin center → Billing → Licenses.

## Administrator Roles

You need one of these roles to import and manage Conditional Access policies:

- **Global Administrator** — Full access (use sparingly)
- **Conditional Access Administrator** — Can manage CA policies
- **Security Administrator** — Can view and manage security settings

For MAM policies, you also need:

- **Intune Administrator** — Can manage app protection policies

## Emergency Access Accounts

You **must** have at least two emergency access (break-glass) accounts before enabling any Conditional Access policies.

These accounts:
- Are excluded from **all** Conditional Access policies
- Use long, complex passwords stored securely (e.g., in a physical safe)
- Do **not** use MFA (to ensure access when MFA is unavailable)
- Are cloud-only accounts (not synced from on-premises AD)
- Have Global Administrator role assigned
- Are monitored for any sign-in activity via alerts

**How to create them:**
1. Go to **Entra admin center** → **Identity** → **Users** → **All users** → **New user** → **Create new user**
2. Create a user like `BreakGlass1@yourdomain.onmicrosoft.com`
3. Set a very long, random password (20+ characters)
4. Assign the **Global Administrator** role
5. Store credentials securely in a physical safe or split-knowledge vault
6. Repeat for a second account
7. Add both accounts to the **CA-EmergencyAccess** security group

## Required Security Groups

Create all groups listed in [groups/required-groups.md](../groups/required-groups.md) before importing policies.

At minimum, create these groups first:

| Group Name | Type | Purpose |
|---|---|---|
| CA-EmergencyAccess | Security (Assigned) | Break-glass accounts |
| CA-ServiceAccounts | Security (Assigned) | Non-interactive service accounts |
| CA-DirectorySyncAccounts | Security (Assigned) | Entra Connect sync accounts |
| CA-ExcludeFromMFA | Security (Assigned) | Temporary MFA exclusions |

## Named Locations

Create named locations before importing CA policies that reference them (CA013, CA020, CA021).

See [named-locations/README.md](../named-locations/README.md) for templates.

## Microsoft Intune

For device compliance policies (CA004, CA008) and MAM policies (CA005, CA006):

- Intune must be configured in your tenant
- Compliance policies should be created for Windows and macOS
- App protection policies must be deployed before CA005/CA006 will work

## Global Secure Access

For CA020 (Require Compliant Network):

- Global Secure Access must be enabled in your tenant
- Traffic forwarding profiles must be configured
- This is **optional** — skip CA020 and GSA configs if not using Global Secure Access

## Terms of Use

For CA014 (Require Terms of Use):

- Create a Terms of Use document in **Entra admin center** → **Identity governance** → **Terms of use**
- Note the Terms of Use ID for use in the policy

## Microsoft Purview

For CA022 (Insider Risk):

- Microsoft Purview Insider Risk Management must be configured
- Adaptive Protection must be enabled
- This is **optional** — skip CA022 if not using Purview Insider Risk

## Verification Checklist

Before starting the import:

- [ ] Licenses verified
- [ ] Admin role confirmed
- [ ] Two emergency access accounts created and tested
- [ ] Emergency accounts added to CA-EmergencyAccess group
- [ ] All required security groups created
- [ ] Named locations created (at least trusted locations)
- [ ] Intune configured with compliance policies
- [ ] App protection policies deployed (for MAM)
- [ ] Global Secure Access enabled (optional, for GSA policies)
- [ ] Terms of Use document created (optional, for CA014)

Once all items are checked, proceed to [GETTING-STARTED.md](GETTING-STARTED.md) for the import walkthrough.
