# Named Locations

This directory contains named location definitions for use with Conditional Access policies. Named locations define trusted or restricted IP ranges and countries that policies reference.

## Location Inventory

| File | Type | Description |
|---|---|---|
| NL001-corporate-offices.json | IP ranges | Corporate office egress IP addresses (USA, EMEA, APAC) |
| NL002-vpn-egress-points.json | IP ranges | VPN concentrator egress IPs |
| NL003-restricted-countries.json | Countries | Countries/regions where access should be blocked |
| NL004-trusted-ipv6-ranges.json | IP ranges | Trusted IPv6 address ranges |
| NL005-datacenter-ranges.json | IP ranges | Datacenter and server room egress IPs |

## How Named Locations Are Used

Named locations are referenced by Conditional Access policies to make location-based decisions. For example, CA013 restricts directory sync to trusted locations, CA020 requires compliant network outside trusted locations, and CA021 blocks access from restricted countries.

## Setup Instructions

1. Open **Microsoft Entra admin center** at [entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to **Protection** → **Conditional Access** → **Named locations**
3. Click **+ IP ranges location** or **+ Countries location**
4. Enter the values from each JSON file
5. Check **Mark as trusted location** for NL001, NL002, NL004, and NL005
6. Note the location ID and update the relevant Conditional Access policies

## Important Notes

> ⚠️ **WARNING**: All IP ranges in these files are **placeholders**. Replace them with your actual corporate IP addresses before use.

> 💡 **TIP**: Mark corporate locations as "trusted" to reduce MFA prompts and false positives in Identity Protection.

## NIS2 Alignment

Named locations support NIS2 Article 21(2)(a) (risk analysis) and 21(2)(e) (network security) by enabling geographic and network-based access controls.
