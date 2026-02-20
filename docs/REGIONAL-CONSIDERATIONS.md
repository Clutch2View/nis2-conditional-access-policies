# Regional Considerations

This repository is designed for organizations with staff in **USA**, **EMEA**, and **APAC** regions. This guide covers region-specific considerations for deploying Conditional Access policies.

## Named Locations by Region

Configure named locations for each region where your organization operates. See [named-locations/README.md](../named-locations/README.md) for templates.

### USA
- Add IP ranges for all US office locations
- Include VPN egress points for US-based remote workers
- Consider state-level data privacy requirements (CCPA, state privacy laws)

### EMEA
- Add IP ranges for all European, Middle Eastern, and African offices
- NIS2 Directive compliance is mandatory for entities in scope within the EU
- GDPR applies — ensure sign-in log retention and data processing align with GDPR requirements
- Consider country-specific data residency requirements

### APAC
- Add IP ranges for all Asia-Pacific office locations
- Consider local data protection laws (PDPA in Singapore, APPI in Japan, Privacy Act in Australia)
- Time zone differences may affect sign-in frequency and session timeout policies

## Country Blocking (CA021)

When configuring CA021 (Block Restricted Countries), consider:

### Recommended Approach
1. Start by blocking countries where your organization has **no legitimate business presence**
2. Common high-risk countries to consider blocking include those with high volumes of credential attacks
3. **Never block countries where your employees are located or traveling**

### Regional Considerations
- **USA organizations**: Consider blocking countries under US sanctions (OFAC list)
- **EMEA organizations**: Consider EU guidance on high-risk third countries
- **APAC organizations**: Consider regional threat intelligence for the Asia-Pacific region

> ⚠️ **WARNING**: Country blocking uses GeoIP data which is not 100% accurate. Some legitimate users may be affected if using VPN services that route through blocked countries.

## Data Residency

### Microsoft 365 Data Locations
- Ensure your Microsoft 365 data residency settings align with regional requirements
- EU Data Boundary for Microsoft 365 may be relevant for EMEA organizations
- APAC organizations should verify data storage locations

### Sign-In Log Retention
- GDPR (EMEA): Ensure sign-in log retention periods comply with data minimization principles
- Different regions may have different retention requirements
- Configure log export to your SIEM per regional requirements

## Time Zone Considerations

### Sign-In Frequency (CA016)
- The 12-hour sign-in frequency applies regardless of time zone
- Users in APAC may experience re-authentication during their workday if the session started in a different time zone
- Consider adjusting the sign-in frequency per regional working patterns if needed

### Terms of Use (CA014)
- Terms of Use documents may need to be available in multiple languages
- Entra ID supports multiple language versions of Terms of Use documents
- Ensure legal review for each region's version

## Regulatory Alignment

| Region | Regulation | Relevance |
|---|---|---|
| EU/EEA | NIS2 Directive (EU 2022/2555) | Primary framework — all policies mapped |
| EU/EEA | GDPR | Data protection, log retention, consent |
| USA | NIST Cybersecurity Framework | Aligns with CA policy best practices |
| USA | CMMC (Defense contractors) | MFA and access control requirements |
| APAC | Various national laws | Country-specific data protection |
| Global | ISO 27001 | Information security management standard |

## Deployment Recommendations by Region

### Multi-Region Rollout Strategy
1. **Start with a pilot region** — choose the region with the most IT support capacity
2. **Deploy in Report-Only** across all regions simultaneously
3. **Enable policies region by region** using the regional groups (CA-AllStaff-USA, CA-AllStaff-EMEA, CA-AllStaff-APAC)
4. **Monitor sign-in logs** for each region after enabling

### Communication
- Notify users in advance about MFA requirements
- Provide region-specific helpdesk contacts
- Consider language requirements for user-facing notifications
- Schedule enabling during each region's business hours for immediate support availability
