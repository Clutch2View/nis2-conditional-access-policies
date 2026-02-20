# Global Secure Access Configurations

This directory contains configuration profiles for **Microsoft Entra Global Secure Access (GSA)**, part of the Microsoft Security Service Edge (SSE) solution.

## What is Global Secure Access?

Global Secure Access provides a cloud-delivered security service that routes traffic through Microsoft's global network. It replaces traditional VPN for Microsoft 365 traffic and provides secure access to private apps and the internet.

## Configuration Profiles

| File | Description |
|---|---|
| GSA001-microsoft-traffic-profile.json | Routes Microsoft 365 traffic through GSA for optimized and secured access |
| GSA002-private-access-profile.json | Provides secure access to on-premises/private applications without VPN |
| GSA003-internet-access-profile.json | Routes internet traffic through GSA for web filtering and threat protection |

## NIS2 Alignment

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(a) | Risk analysis — network-level security for all traffic |
| Article 21(2)(e) | Security in network and information systems |

## Deployment Order

1. Deploy GSA001 (Microsoft traffic) first — lowest risk, highest impact
2. Deploy GSA002 (Private access) to replace VPN
3. Deploy GSA003 (Internet access) last — broadest scope
4. Enable CA020 to enforce compliant network requirement

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Global Secure Access licenses (included in Microsoft 365 E5 Security)
- GSA client deployed to managed devices
- Network connectivity to Microsoft Global Secure Access points of presence

> ⚠️ **WARNING**: These are reference configurations. Adapt them to your network architecture before deployment. Test thoroughly in a pilot group.
