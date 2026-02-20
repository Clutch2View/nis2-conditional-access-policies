# NIS2 Directive Article 21 — Policy Mapping

This document maps every policy in this repository to specific requirements of the **NIS2 Directive (EU 2022/2555) Article 21** on cybersecurity risk-management measures.

## About NIS2 Article 21

Article 21 of the NIS2 Directive requires essential and important entities to take appropriate and proportionate technical, operational, and organisational measures to manage the risks posed to the security of network and information systems. The measures must be based on an all-hazards approach and cover at minimum the areas listed in Article 21(2).

## Mapping Table

| NIS2 Requirement | Article | Policy IDs | How It Is Addressed |
|---|---|---|---|
| **Risk analysis and information system security policies** | 21(2)(a) | CA001, CA004, CA005, CA006, CA007, CA009, CA010, CA017, CA018, CA020, CA021 | Legacy authentication blocked to eliminate known attack vector. Device compliance enforced for Windows/macOS via MDM. App protection policies enforced for iOS/Android via MAM. Unknown platforms blocked. High-risk sign-ins and users blocked. Device code flow blocked. Token protection enabled. Network security via Global Secure Access. Geographic restrictions on sign-ins. |
| **Incident handling** | 21(2)(b) | CA009, CA010, CA011, CA022 | Automated response to high-risk sign-ins (block). Automated response to high-risk users (block). Medium-risk users required to change password. Integration with Microsoft Purview Insider Risk Management for adaptive protection. |
| **Business continuity and crisis management** | 21(2)(c) | CA000, CA020 | Emergency access (break-glass) accounts ensure continued access during crisis scenarios or authentication service issues. Global Secure Access provides network resilience and redundant connectivity. |
| **Supply chain security including security aspects of relationships between entities** | 21(2)(d) | CA005, CA006, CA015, CA019 | MAM policies control data on personal devices without requiring full device management. App-enforced restrictions limit data access on unmanaged devices. Guest and external user access restricted to specific applications with MFA required. |
| **Security in network and information systems acquisition, development, and maintenance** | 21(2)(e) | CA004, CA008, CA020, GSA001, GSA002, GSA003 | Only compliant (MDM-enrolled) devices can access corporate resources on Windows/macOS. Admin portals require compliant devices. Global Secure Access provides network-level security inspection for Microsoft traffic, private access, and internet access. |
| **Policies and procedures to assess the effectiveness of cybersecurity risk-management measures** | 21(2)(f) | All Policies | Every policy ships in Report-Only mode, enabling organizations to assess impact before enforcement. The What If tool and sign-in log analysis allow continuous effectiveness assessment. Conditional Access insights workbook provides ongoing monitoring. |
| **Basic cyber hygiene practices and cybersecurity training** | 21(2)(g) | CA014 | Terms of Use policy requires all users to acknowledge and accept acceptable use policies before accessing cloud resources. Documentation serves as reference material for security awareness. |
| **Policies and procedures regarding the use of cryptography and where appropriate encryption** | 21(2)(h) | MAM001, MAM002, MAM003, CA004 | MAM policies enforce app-level encryption for organizational data on mobile devices. MDM compliance policies on Windows/macOS enforce disk encryption (BitLocker/FileVault). Data-in-transit is protected through enforced TLS and Global Secure Access tunneling. |
| **Human resources security, access control policies, and asset management** | 21(2)(i) | CA003, CA008, CA012, CA013, CA016, CA022 | All administrator roles require MFA. Admin portals require compliant devices. Admins require phishing-resistant MFA (FIDO2/WHfB). Directory sync restricted to trusted locations. Sign-in frequency controls manage session lifetimes. Insider risk integration enables adaptive access control based on user behavior. |
| **Use of multi-factor authentication or continuous authentication solutions** | 21(2)(j) | CA002, CA003, CA012, CA019 | MFA required for all users across all cloud applications. All administrator roles require MFA with dedicated policy. Administrators require phishing-resistant authentication (FIDO2, Windows Hello for Business, certificate-based authentication). External and guest users require MFA. |

## Detailed Policy-to-NIS2 Cross-Reference

### CA000: Emergency Access Accounts
- **NIS2 Article**: 21(2)(c) — Business continuity and crisis management
- **Rationale**: Break-glass accounts ensure the organization can maintain access to critical systems during authentication service outages or misconfigured policies.

### CA001: Block Legacy Authentication
- **NIS2 Article**: 21(2)(a) — Risk analysis and information system security policies
- **Rationale**: Legacy authentication protocols do not support MFA and are frequently exploited in password spray and credential stuffing attacks. Blocking them eliminates a known high-risk attack vector.

### CA002: Require MFA — All Users
- **NIS2 Article**: 21(2)(j) — Multi-factor authentication
- **Rationale**: Directly implements the NIS2 requirement for multi-factor authentication across the organization.

### CA003: Require MFA — Admins
- **NIS2 Articles**: 21(2)(i) — Access control, 21(2)(j) — Multi-factor authentication
- **Rationale**: Privileged accounts require enhanced protection. Admin-specific MFA policy ensures coverage even if the general MFA policy is modified.

### CA004: Require Compliant Device — Windows/macOS
- **NIS2 Articles**: 21(2)(a) — Information system security, 21(2)(e) — System acquisition and maintenance, 21(2)(h) — Cryptography/encryption
- **Rationale**: Ensures corporate devices meet security baselines including encryption, antivirus, and patch levels through Intune compliance policies.

### CA005: Require App Protection — iOS/iPadOS
- **NIS2 Articles**: 21(2)(a) — Information system security, 21(2)(d) — Supply chain security
- **Rationale**: Enables secure access from personal iOS devices through app-level protection without requiring full device management, supporting BYOD while maintaining data protection.

### CA006: Require App Protection — Android
- **NIS2 Articles**: 21(2)(a) — Information system security, 21(2)(d) — Supply chain security
- **Rationale**: Same as CA005 but for the Android platform.

### CA007: Block Unknown Platforms
- **NIS2 Article**: 21(2)(a) — Risk analysis and information system security
- **Rationale**: Reduces attack surface by blocking access from unsupported or unknown device platforms.

### CA008: Require Compliant Device — Admin Portals
- **NIS2 Articles**: 21(2)(e) — System security, 21(2)(i) — Access control
- **Rationale**: Admin portal access is restricted to compliant, managed devices to prevent administrative actions from insecure endpoints.

### CA009: Block High-Risk Sign-Ins
- **NIS2 Articles**: 21(2)(a) — Risk analysis, 21(2)(b) — Incident handling
- **Rationale**: Automated blocking of sign-ins identified as high risk by Microsoft Entra ID Protection, providing real-time incident response.

### CA010: Block High-Risk Users
- **NIS2 Articles**: 21(2)(a) — Risk analysis, 21(2)(b) — Incident handling
- **Rationale**: Users flagged as compromised are automatically blocked, containing potential breaches.

### CA011: Password Change — Medium Risk Users
- **NIS2 Article**: 21(2)(b) — Incident handling
- **Rationale**: Medium-risk users must change their password and complete MFA, providing graduated incident response.

### CA012: Phishing-Resistant MFA — Admins
- **NIS2 Articles**: 21(2)(i) — Access control, 21(2)(j) — Multi-factor authentication
- **Rationale**: Administrators are required to use phishing-resistant authentication methods (FIDO2, Windows Hello for Business) to prevent credential theft targeting privileged accounts.

### CA013: Restrict Directory Sync
- **NIS2 Article**: 21(2)(i) — Access control
- **Rationale**: Directory synchronization is restricted to trusted network locations to prevent unauthorized sync operations.

### CA014: Terms of Use
- **NIS2 Article**: 21(2)(g) — Basic cyber hygiene and training
- **Rationale**: Users must acknowledge acceptable use policies, supporting security awareness and establishing legal accountability.

### CA015: App-Enforced Restrictions
- **NIS2 Article**: 21(2)(d) — Supply chain security / data access
- **Rationale**: Limits functionality on unmanaged devices to prevent data leakage while still allowing controlled access.

### CA016: Sign-In Frequency
- **NIS2 Article**: 21(2)(i) — Access control, session management
- **Rationale**: Enforces session lifetime limits to reduce the window of opportunity for session hijacking.

### CA017: Block Device Code Flow
- **NIS2 Article**: 21(2)(a) — Risk analysis, preventing known attack vectors
- **Rationale**: Device code flow is frequently abused in phishing attacks. Blocking it eliminates this attack vector.

### CA018: Token Protection
- **NIS2 Article**: 21(2)(a) — Information system security
- **Rationale**: Token binding prevents token theft and replay attacks by cryptographically binding tokens to the device.

### CA019: Restrict Guest Access
- **NIS2 Article**: 21(2)(d) — Supply chain and third-party security
- **Rationale**: External users are limited to specific applications and require MFA, controlling third-party access exposure.

### CA020: Require Compliant Network (GSA)
- **NIS2 Articles**: 21(2)(a) — Network security, 21(2)(c) — Business continuity
- **Rationale**: Global Secure Access provides network-level security inspection and ensures traffic flows through compliant network paths.

### CA021: Block Restricted Countries
- **NIS2 Article**: 21(2)(a) — Risk-based access controls
- **Rationale**: Geographic restrictions block sign-ins from high-risk regions where the organization has no legitimate business presence.

### CA022: Insider Risk Restrictions
- **NIS2 Articles**: 21(2)(b) — Incident handling, 21(2)(i) — Access control
- **Rationale**: Integration with Microsoft Purview Insider Risk Management enables adaptive access controls based on user behavior patterns.

## MAM Policies

| Policy | NIS2 Article | Rationale |
|---|---|---|
| MAM001: iOS App Protection | 21(2)(a), 21(2)(d), 21(2)(h) | Enforces data protection, encryption, and access controls on iOS devices |
| MAM002: Android App Protection | 21(2)(a), 21(2)(d), 21(2)(h) | Enforces data protection, encryption, and access controls on Android devices |
| MAM003: Windows App Protection | 21(2)(a), 21(2)(h) | Supplementary data protection for Windows Edge browser |
| MAM004: iOS App Configuration | 21(2)(a) | Pre-configures security settings for managed applications |

## Global Secure Access

| Configuration | NIS2 Article | Rationale |
|---|---|---|
| GSA001: Microsoft Traffic | 21(2)(a), 21(2)(e) | Routes M365 traffic through secure inspection |
| GSA002: Private Access | 21(2)(a), 21(2)(e) | Secures access to internal applications |
| GSA003: Internet Access | 21(2)(a), 21(2)(e) | Filters and secures internet traffic |

## Disclaimer

This mapping is provided as technical guidance to support NIS2 compliance efforts. It is not legal advice. Organizations should consult with their legal and compliance teams to ensure full compliance with the NIS2 Directive as applicable in their jurisdiction.
