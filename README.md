[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![NIS2 Compliant](https://img.shields.io/badge/NIS2-Compliant-blue.svg)](NIS2-MAPPING.md)
[![Last Updated](https://img.shields.io/badge/Updated-2025--02-orange.svg)](#)
[![Microsoft Entra ID](https://img.shields.io/badge/Microsoft%20Entra%20ID-Conditional%20Access-0078D4.svg)](#)
[![M365 E5](https://img.shields.io/badge/Microsoft%20365-E5-red.svg)](#)

# NIS2 Conditional Access Policies

> **Plug-and-play Conditional Access policies for Microsoft 365 E5 tenants — NIS2 compliant, no PowerShell required.**

## What This Is

A free, open-source collection of **pre-built Conditional Access policies**, **App Protection (MAM) policies**, and **Global Secure Access configurations** that can be imported directly into Microsoft Entra ID through the admin portal GUI. No scripting. No command line. Just download the JSON files and import them.

Designed for organizations that:

- Hold a **Microsoft 365 E5** license (or equivalent component licenses)
- Have staff located across **USA, EMEA, and APAC** regions
- Use **iPhones and iPads** managed through **MAM only** (no MDM enrollment required for iOS/iPadOS)
- Use **Windows and macOS** corporate-owned devices managed through **MDM (Intune)**
- Need to comply with the **NIS2 Directive (EU 2022/2555) Article 21** cybersecurity risk management requirements

## Key Features

- **22+ Conditional Access policies** covering all NIS2 Article 21 requirements
- **MAM-only management** for iPhones and iPads — no MDM/device enrollment needed
- **MDM compliance policies** for Windows and macOS corporate devices
- **Global Secure Access** configuration for secure network access
- **Region-aware policies** for USA, EMEA, and APAC
- **Every policy ships in Report-Only mode** for safe testing
- **JSON import** — no PowerShell, no scripting, no CLI required
- **Complete NIS2 Article 21 mapping** documentation

## Quick Start

Getting up and running takes six steps:

1. **Download** or clone this repository
2. **Create** the required Entra ID security groups (see [`groups/required-groups.md`](groups/required-groups.md))
3. **Create** the named locations (see [`named-locations/README.md`](named-locations/README.md))
4. **Import** policies one by one via **Entra admin center → Protection → Conditional Access → Policies → Import**
5. **Update** placeholder GUIDs with your tenant's actual group and user IDs
6. **Test** in Report-Only mode, review sign-in logs, then gradually switch policies to **On**

For a detailed walkthrough, see the [Getting Started Guide](docs/GETTING-STARTED.md).

## Architecture

```
                         ┌─────────────────────────┐
                         │       User Request       │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │    Microsoft Entra ID    │
                         │  (Conditional Access     │
                         │       Policies)          │
                         └────────────┬────────────┘
                                      │
                    ┌─────────────────┼─────────────────┐
                    │                 │                  │
                    ▼                 ▼                  ▼
          ┌─────────────┐  ┌──────────────────┐  ┌───────────┐
          │  Compliant   │  │  App Protection  │  │   Block   │
          │   Device     │  │     Policy       │  │  Access   │
          │ (Win/macOS   │  │  (iOS/iPadOS     │  │           │
          │   via MDM)   │  │    via MAM)      │  │           │
          └──────┬───────┘  └────────┬─────────┘  └───────────┘
                 │                   │
                 ▼                   ▼
          ┌─────────────────────────────────────┐
          │          Access Granted              │
          │   (through Global Secure Access)     │
          └─────────────────────────────────────┘
```

## NIS2 Compliance Summary

Every policy in this repository maps to specific NIS2 Directive Article 21(2) requirements:

| NIS2 Requirement | Sub-section | Policy IDs | Coverage |
|---|---|---|---|
| Risk analysis & information system security | 21(2)(a) | CA001, CA004, CA005, CA007, CA009, CA010, CA020, CA021 | Legacy auth blocked, device compliance, platform restrictions, risk-based controls, geo-blocking |
| Incident handling | 21(2)(b) | CA009, CA010, CA011, CA022 | Automated response to risky sign-ins/users, insider risk |
| Business continuity | 21(2)(c) | CA000, CA020 | Emergency access accounts, GSA network resilience |
| Supply chain security | 21(2)(d) | CA005, CA006, CA015, CA019 | MAM on personal devices, guest restrictions |
| Network & information system security | 21(2)(e) | CA004, CA020, GSA001-003 | Compliant devices, Global Secure Access |
| Effectiveness assessment | 21(2)(f) | All policies | Every policy starts in Report-Only mode |
| Cyber hygiene & training | 21(2)(g) | CA014 | Terms of Use acceptance |
| Cryptography & encryption | 21(2)(h) | MAM001-003, CA004 | App-level + disk encryption |
| HR security & access control | 21(2)(i) | CA003, CA008, CA012, CA013, CA016 | Admin controls, session management |
| Multi-factor authentication | 21(2)(j) | CA002, CA003, CA012, CA019 | MFA all users, phishing-resistant for admins |

For the full mapping, see [NIS2-MAPPING.md](NIS2-MAPPING.md).

## Repository Structure

```
nis2-conditional-access-policies/
├── LICENSE
├── README.md                           ← You are here
├── CONTRIBUTING.md
├── CHANGELOG.md
├── NIS2-MAPPING.md
│
├── docs/
│   ├── GETTING-STARTED.md
│   ├── PREREQUISITES.md
│   ├── POLICY-OVERVIEW.md
│   ├── REGIONAL-CONSIDERATIONS.md
│   ├── MAM-GUIDE.md
│   ├── GLOBAL-SECURE-ACCESS.md
│   ├── TROUBLESHOOTING.md
│   ├── FAQ.md
│   └── CUSTOMIZATION.md
│
├── policies/
│   ├── conditional-access/             (22 policy folders with JSON + README)
│   ├── app-protection-mam/             (MAM policies for iOS, Android, Windows)
│   └── global-secure-access/           (GSA traffic profiles)
│
├── named-locations/                    (Trusted locations & blocked countries)
├── groups/                             (Required Entra ID groups)
└── scripts/                            (Optional helper scripts)
```

## Policies Included

### Conditional Access Policies (22)

| # | Policy | Purpose |
|---|---|---|
| CA000 | Emergency Access Exclusion | Ensures break-glass accounts are never locked out |
| CA001 | Block Legacy Authentication | Blocks insecure legacy auth protocols |
| CA002 | Require MFA — All Users | MFA for every user on every app |
| CA003 | Require MFA — Admins | MFA specifically for all admin roles |
| CA004 | Require Compliant Device — Win/macOS | MDM compliance for corporate devices |
| CA005 | Require App Protection — iOS/iPadOS | MAM policy for iPhones/iPads (no MDM) |
| CA006 | Require App Protection — Android | MAM policy for Android devices |
| CA007 | Block Unknown Platforms | Block unsupported device platforms |
| CA008 | Require Compliant Device — Admin Portals | MDM compliance for admin portal access |
| CA009 | Block High-Risk Sign-Ins | Block sign-ins flagged as high risk |
| CA010 | Block High-Risk Users | Block users flagged as high risk |
| CA011 | Password Change — Medium Risk | Force password change for medium-risk users |
| CA012 | Phishing-Resistant MFA — Admins | FIDO2/WHfB for admin roles |
| CA013 | Restrict Directory Sync | Limit sync to trusted locations |
| CA014 | Require Terms of Use | Acceptance of usage terms |
| CA015 | App-Enforced Restrictions | Limited access on unmanaged devices |
| CA016 | Sign-In Frequency | Session lifetime controls |
| CA017 | Block Device Code Flow | Prevent device code phishing |
| CA018 | Token Protection | Prevent token theft/replay |
| CA019 | Restrict Guest Access | Limit external user access |
| CA020 | Require Compliant Network (GSA) | Enforce Global Secure Access |
| CA021 | Block Restricted Countries | Geo-block high-risk regions |
| CA022 | Insider Risk Restrictions | Adaptive protection integration |

### App Protection (MAM) Policies (4)

| # | Policy | Platform |
|---|---|---|
| MAM001 | iOS/iPadOS App Protection | iOS/iPadOS |
| MAM002 | Android App Protection | Android |
| MAM003 | Windows App Protection | Windows |
| MAM004 | iOS App Configuration | iOS/iPadOS |

### Global Secure Access (3)

| # | Configuration | Purpose |
|---|---|---|
| GSA001 | Microsoft Traffic Profile | Route M365 traffic through GSA |
| GSA002 | Private Access Profile | Internal app access |
| GSA003 | Internet Access Profile | Web filtering & security |

## Important Disclaimers

> ⚠️ **TEST BEFORE ENFORCING**: Every policy ships in **Report-Only** mode. Never switch a policy to **On** without reviewing its impact in sign-in logs first.

> ⚠️ **NOT LEGAL ADVICE**: This repository provides technical controls that support NIS2 compliance. It is not legal compliance advice. Review all policies with your security and legal teams.

> ⚠️ **CUSTOMIZE FOR YOUR ORG**: Placeholder GUIDs must be replaced with your actual group, user, and location IDs before policies will function correctly.

> ⚠️ **EMERGENCY ACCESS**: Always maintain at least two emergency access (break-glass) accounts that are excluded from all Conditional Access policies.

## Prerequisites

Before importing any policies, you need:

- Microsoft 365 E5 license (or Microsoft Entra ID P2 + Intune P2 + Microsoft Defender for Cloud Apps)
- Global Administrator or Conditional Access Administrator role
- Emergency access accounts created (at least 2)
- Required security groups created in Entra ID
- Named locations configured

See [Prerequisites](docs/PREREQUISITES.md) for the full checklist.

## Contributing

We welcome contributions! Whether it's fixing a typo, suggesting a new policy, or improving documentation — every contribution helps.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for the full text.

## Acknowledgments

- Microsoft documentation for Conditional Access best practices
- NIS2 Directive (EU 2022/2555) for the compliance framework
- The open-source security community for continuous improvement

---

**Made with care for the IT admin community. Stay secure. Stay compliant.**
