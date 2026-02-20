# CA020: Require Compliant Network — Global Secure Access

## What This Policy Does

This policy requires users to connect through a **compliant network** (Global Secure Access / Microsoft Entra Private Access) when accessing cloud applications from untrusted locations. Users on trusted named locations are exempt. This ensures all traffic is routed through your secure network perimeter, providing DLP, threat inspection, and network-level controls.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — ensures network-level security for all access |
| Article 21(2)(e) | Security in network and information systems |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Emergency Access Accounts group |

> ⚠️ **WARNING**: Global Secure Access must be fully configured and the GSA client deployed to all devices before enabling this policy. See the GSA configurations in policies/global-secure-access/.

---

## Prerequisites

- Global Secure Access configured (see GSA001-GSA003)
- GSA client deployed to all managed devices
- Trusted named locations configured (NL001-NL005)
- Emergency Access Accounts group exists

---

## Import Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Policies**
3. Click **+ New policy**
4. Configure:
   - **Name**: `CA020: Require Compliant Network — Global Secure Access`
   - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
   - **Target resources**: **All cloud apps**
   - **Conditions** → **Locations**: Include **All locations**, Exclude **All trusted locations**
   - **Grant**: Require **compliant network**
5. Set to **Report-only** mode
6. Click **Create**

---

## What Does This Look Like for the End User?

- **On corporate network / trusted location**: No impact.
- **Remote with GSA client**: Traffic routed through GSA — transparent to user.
- **Without GSA client on untrusted network**: Blocked until GSA client is connected.

---

## Dependencies

| Policy | Reason |
|---|---|
| GSA001-GSA003 | Global Secure Access profiles must be configured |
| NL001-NL005 | Trusted locations must be defined |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| Remote users blocked | Ensure GSA client is installed and connected |
| GSA client not connecting | Check network connectivity and client configuration |
| Users on trusted network still prompted | Verify the trusted named locations match the actual egress IPs |

---

## Related Policies

- **GSA001-GSA003**: Global Secure Access configuration profiles
- **NL001-NL005**: Named location definitions
