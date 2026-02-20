# Global Secure Access Setup Guide

Global Secure Access is Microsoft's Security Service Edge (SSE) solution, built into Microsoft Entra. It provides network-level security for Microsoft 365 traffic, private applications, and internet access.

## Overview

Global Secure Access has three traffic forwarding profiles:

1. **Microsoft Traffic Profile** (GSA001) — Routes Microsoft 365 traffic through the secure network
2. **Private Access Profile** (GSA002) — Provides zero-trust network access to internal applications
3. **Internet Access Profile** (GSA003) — Filters and secures general internet traffic

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Microsoft 365 E3/E5 or equivalent
- Global Administrator or Security Administrator role
- Global Secure Access must be enabled in your tenant

## Step 1: Enable Global Secure Access

1. Sign in to **[entra.microsoft.com](https://entra.microsoft.com)**
2. Navigate to **Global Secure Access** → **Get started**
3. Click **Activate** to enable Global Secure Access in your tenant
4. Wait for activation to complete (may take a few minutes)

## Step 2: Configure Microsoft Traffic Profile (GSA001)

This profile routes Microsoft 365 traffic through Global Secure Access for inspection and policy enforcement.

1. Go to **Global Secure Access** → **Connect** → **Traffic forwarding**
2. Enable **Microsoft traffic profile**
3. Review the included Microsoft 365 services (Exchange, SharePoint, Teams, etc.)
4. Click **Save**

## Step 3: Configure Private Access Profile (GSA002)

Private Access provides secure access to internal/private applications without requiring a traditional VPN.

1. Go to **Global Secure Access** → **Connect** → **Traffic forwarding**
2. Enable **Private access profile**
3. Configure **Quick Access**:
   - Add your internal application FQDNs or IP ranges
   - Configure connector groups (requires Entra Private Network connectors installed on-premises)
4. Click **Save**

> 💡 **NOTE**: Private Access requires connectors installed in your on-premises environment. See Microsoft documentation for connector deployment.

## Step 4: Configure Internet Access Profile (GSA003)

Internet Access provides web content filtering and security for general internet traffic.

1. Go to **Global Secure Access** → **Connect** → **Traffic forwarding**
2. Enable **Internet access profile**
3. Go to **Global Secure Access** → **Secure** → **Security profiles**
4. Create a security profile with web content filtering rules:
   - Block categories: Malware, Phishing, Adult content, Gambling, etc.
   - Allow categories as needed for your organization
5. Link the security profile to the internet access profile

## Step 5: Deploy the Global Secure Access Client

For the profiles to work on end-user devices:

1. Deploy the **Global Secure Access Client** to Windows devices via Intune
2. macOS client is available in preview
3. The client automatically routes traffic through Global Secure Access based on the configured profiles

## Step 6: Link to Conditional Access (CA020)

After Global Secure Access is configured:

1. Import **CA020** (Require Compliant Network — GSA)
2. This policy requires traffic to flow through the Global Secure Access compliant network
3. Test in Report-Only mode before enabling

## NIS2 Relevance

Global Secure Access addresses:

- **Article 21(2)(a)**: Network security through traffic inspection and filtering
- **Article 21(2)(c)**: Business continuity through redundant network connectivity
- **Article 21(2)(e)**: Security in network and information systems

## Important Notes

- Global Secure Access is still evolving — some features may be in preview
- Not all features are available in all regions
- The CA020 policy is optional — your other policies work independently without GSA
- Test thoroughly in your environment before enforcing
