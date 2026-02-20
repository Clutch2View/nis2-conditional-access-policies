# CA000: Emergency Access Accounts

## Overview

This is a **documentation-only** entry — there is no JSON policy file to import. Instead, this documents the critical requirement that every other Conditional Access policy must exclude your emergency access (break-glass) accounts.

## What Are Emergency Access Accounts?

Emergency access accounts are highly privileged accounts that are excluded from all Conditional Access policies. They ensure you can always access your tenant, even if:
- MFA services are down
- A misconfigured CA policy locks out all admins
- Your identity provider has an outage
- A federation failure prevents normal sign-in

## How to Create Emergency Access Accounts

### Account 1: Cloud-Only Break-Glass
1. Go to **Entra admin center** → **Identity** → **Users** → **All users** → **New user** → **Create new user**
2. Username: `BreakGlass1@yourtenant.onmicrosoft.com`
3. Use the `.onmicrosoft.com` domain (not your custom domain)
4. Set a very long, random password (20+ characters)
5. Assign **Global Administrator** role
6. Do NOT enable MFA on this account
7. Store credentials securely in a physical safe with split knowledge

### Account 2: Cloud-Only Break-Glass
1. Repeat the process for `BreakGlass2@yourtenant.onmicrosoft.com`
2. Use different credentials than Account 1
3. Store in a different physical location if possible

### Create the Security Group
1. Go to **Identity** → **Groups** → **All groups** → **New group**
2. Group type: **Security**
3. Group name: **CA-EmergencyAccess**
4. Membership type: **Assigned**
5. Add both break-glass accounts as members
6. Note the **Object ID** of this group — you will use it in every CA policy

## How Emergency Access Exclusions Work

Every CA policy in this repository has the following in its exclude configuration:

```json
"excludeGroups": [
    "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
]
```

Replace `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` with the Object ID of your **CA-EmergencyAccess** group.

## Monitoring

Set up alerts for emergency access account usage:
1. Go to **Entra admin center** → **Identity** → **Monitoring & health** → **Sign-in logs**
2. Create a diagnostic setting to send logs to Log Analytics
3. Create an alert rule that triggers when either break-glass account signs in
4. Route alerts to your security operations team

## NIS2 Mapping

**Article 21(2)(c)** — Business continuity and crisis management. Emergency access accounts ensure continued access to critical systems during incidents.

## Important Notes

> ⚠️ **NEVER** remove emergency access accounts from the exclusion group
> ⚠️ **TEST** emergency access accounts regularly (quarterly at minimum)
> ⚠️ **MONITOR** all sign-ins from these accounts — any usage should trigger investigation
> ⚠️ **STORE** credentials securely with split knowledge (two people each know half the password)
