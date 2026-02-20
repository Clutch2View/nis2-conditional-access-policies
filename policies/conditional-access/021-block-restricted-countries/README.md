# CA021: Block Access from Restricted Countries

## What This Policy Does

This policy blocks all access to cloud apps from countries/regions that your organization has identified as restricted. Use the **NL003: Restricted Countries** named location to define which countries are blocked. This is a geographic access control that prevents sign-ins from high-risk regions where the organization has no business presence.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — geofencing reduces attack surface |
| Article 21(2)(e) | Security in network and information systems acquisition |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in excludeGroups) | Emergency Access Accounts group |
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in includeLocations) | Restricted Countries named location ID (NL003) |

> ⚠️ **WARNING**: You must create the NL003 named location with your restricted countries list before this policy will work. Replace both placeholder GUIDs.

---

## Prerequisites

- Named location NL003 created with restricted countries
- Emergency Access Accounts group exists
- Review travel patterns to avoid blocking legitimate users

---

## Import Instructions

1. First, create the restricted countries named location (NL003)
2. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
3. Navigate to **Protection** → **Conditional Access** → **Policies**
4. Click **+ New policy**
5. Configure:
   - **Name**: `CA021: Block Access from Restricted Countries`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Locations**: Include your **Restricted Countries** named location
   - **Grant**: **Block access**
6. Set to **Report-only** mode
7. Click **Create**

---

## What Does This Look Like for the End User?

- **Users in allowed countries**: No impact.
- **Users in restricted countries**: Blocked with a denial message. Must use VPN to a trusted location or contact IT.
- **Traveling users**: If traveling to a restricted country, they must connect via VPN or Global Secure Access.

---

## Dependencies

| Policy | Reason |
|---|---|
| NL003 | Restricted countries named location must be defined |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Employee traveling to restricted country blocked | Set up VPN access before travel, or add a temporary exclusion |
| VPN traffic still blocked | Ensure VPN egress is in an allowed country/trusted location |
| False positive country detection | IP geolocation is not 100% accurate — review sign-in logs |

---

## Related Policies

- **NL003**: Restricted Countries named location
- **CA020**: Require Compliant Network via GSA
