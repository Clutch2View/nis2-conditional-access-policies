# Policy Overview

A complete summary of every policy in this repository, what it does, and why it matters.

## Conditional Access Policies

| # | Display Name | Applies To | Grant/Session Control | NIS2 Article | State |
|---|---|---|---|---|---|
| CA000 | Emergency Access Exclusion | Documentation only | N/A | 21(2)(c) | N/A |
| CA001 | Block Legacy Authentication — All Users | All users (excl. emergency) | Block | 21(2)(a) | Report-Only |
| CA002 | Require MFA — All Users | All users (excl. emergency, service accts) | Require MFA | 21(2)(j) | Report-Only |
| CA003 | Require MFA — All Administrators | Admin directory roles | Require MFA | 21(2)(i), 21(2)(j) | Report-Only |
| CA004 | Require Compliant Device — Windows/macOS | All users, Windows/macOS only | Require compliant device | 21(2)(a), 21(2)(e) | Report-Only |
| CA005 | Require App Protection — iOS/iPadOS | All users, iOS only | Require app protection policy | 21(2)(a), 21(2)(d) | Report-Only |
| CA006 | Require App Protection — Android | All users, Android only | Require app protection policy | 21(2)(a), 21(2)(d) | Report-Only |
| CA007 | Block Unknown/Unsupported Platforms | All users, unknown platforms | Block | 21(2)(a) | Report-Only |
| CA008 | Require Compliant Device — Admin Portals | All users, admin portal apps | Require compliant device | 21(2)(e), 21(2)(i) | Report-Only |
| CA009 | Block High-Risk Sign-Ins | All users, high sign-in risk | Block | 21(2)(a), 21(2)(b) | Report-Only |
| CA010 | Block High-Risk Users | All users, high user risk | Block | 21(2)(a), 21(2)(b) | Report-Only |
| CA011 | Password Change — Medium Risk Users | All users, medium user risk | Require password change + MFA | 21(2)(b) | Report-Only |
| CA012 | Phishing-Resistant MFA — Admins | Admin directory roles | Require phishing-resistant MFA | 21(2)(i), 21(2)(j) | Report-Only |
| CA013 | Restrict Directory Sync — Trusted Locations | Directory sync accounts | Block (outside trusted locations) | 21(2)(i) | Report-Only |
| CA014 | Require Terms of Use | All users | Require Terms of Use | 21(2)(g) | Report-Only |
| CA015 | App-Enforced Restrictions — Unmanaged | All users, Exchange/SharePoint | App-enforced restrictions (session) | 21(2)(d) | Report-Only |
| CA016 | Sign-In Frequency Control | All users | 12-hour sign-in frequency (session) | 21(2)(i) | Report-Only |
| CA017 | Block Device Code Authentication Flow | All users | Block | 21(2)(a) | Report-Only |
| CA018 | Token Protection — Sign-In Sessions | All users, Windows only | Require token protection (session) | 21(2)(a) | Report-Only |
| CA019 | Restrict External/Guest Access | Guest/external users | Require MFA, limited apps | 21(2)(d) | Report-Only |
| CA020 | Require Compliant Network — GSA | All users | Require compliant network | 21(2)(a), 21(2)(c) | Report-Only |
| CA021 | Block Sign-Ins — Restricted Countries | All users, blocked locations | Block | 21(2)(a) | Report-Only |
| CA022 | Restrict Elevated Insider Risk | Users with elevated insider risk | Conditional Access App Control (session) | 21(2)(b), 21(2)(i) | Report-Only |

## App Protection (MAM) Policies

| # | Policy Name | Platform | Key Settings |
|---|---|---|---|
| MAM001 | iOS/iPadOS App Protection | iOS/iPadOS | Data encryption, restrict copy/paste, PIN required, block jailbroken, min OS 16.0 |
| MAM002 | Android App Protection | Android | Data encryption, restrict copy/paste, PIN required, block rooted, min OS 13.0 |
| MAM003 | Windows App Protection | Windows | Edge browser data protection, restrict copy/paste and printing |
| MAM004 | iOS App Configuration | iOS/iPadOS | Outlook email configuration, Focused Inbox, block external images |

## Global Secure Access Configurations

| # | Configuration | Purpose |
|---|---|---|
| GSA001 | Microsoft Traffic Profile | Route Microsoft 365 traffic through Global Secure Access |
| GSA002 | Private Access Profile | Secure access to internal/private applications |
| GSA003 | Internet Access Profile | Web content filtering and internet security |

## Named Locations

| # | Location Name | Type | Purpose |
|---|---|---|---|
| NL001 | USA Corporate Offices | IP ranges | Trusted US office locations |
| NL002 | EMEA Corporate Offices | IP ranges | Trusted EMEA office locations |
| NL003 | APAC Corporate Offices | IP ranges | Trusted APAC office locations |
| NL004 | Trusted IP Ranges | IP ranges | VPN and other trusted egress points |
| NL005 | Blocked Countries | Countries/regions | High-risk countries to block |

## Policy Dependencies

Some policies depend on other configurations being in place:

- **CA005/CA006** require MAM001/MAM002 to be deployed first
- **CA008** requires Intune compliance policies configured
- **CA013** requires named locations (trusted locations) configured
- **CA014** requires a Terms of Use document created in Entra ID
- **CA020** requires Global Secure Access enabled and configured
- **CA021** requires the Blocked Countries named location configured
- **CA022** requires Microsoft Purview Insider Risk Management configured
