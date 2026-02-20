# Frequently Asked Questions

## General

**Q: Do I need PowerShell to use this repository?**
A: No. Every policy can be imported through the Entra admin center GUI. The scripts in the /scripts folder are optional helper tools.

**Q: What license do I need?**
A: Microsoft 365 E5, or the equivalent combination of Microsoft Entra ID P2 + Intune P2 + Microsoft Defender for Cloud Apps.

**Q: Will these policies work with Microsoft 365 E3?**
A: Partially. Policies that require Entra ID Protection (CA009-CA011), Identity Protection risk levels, or advanced features require E5/P2 licensing. Basic MFA and device compliance policies work with E3.

**Q: Are the policies automatically enforced when imported?**
A: No. Every policy ships in Report-Only mode. You must manually change each policy to "On" after testing.

**Q: Can I import all policies at once?**
A: You should import them one at a time to verify each one. Follow the recommended import order in the Getting Started guide.

## NIS2 Compliance

**Q: Does using these policies make my organization NIS2 compliant?**
A: These policies address the technical controls specified in Article 21. NIS2 compliance also requires organizational measures, governance, incident reporting procedures, and other non-technical requirements. Consult your legal team.

**Q: Is this repository official guidance from the EU or Microsoft?**
A: No. This is a community-created resource that maps Microsoft security controls to NIS2 requirements. Always verify with your compliance team.

**Q: Does NIS2 apply to my organization?**
A: NIS2 applies to essential and important entities in the EU/EEA. Check with your legal team to determine if your organization is in scope.

## Policy-Specific

**Q: Why are iPhones using MAM instead of MDM?**
A: This repository is designed for organizations that want to allow iPhone/iPad access without requiring full device enrollment. MAM protects corporate data at the app level while respecting user privacy on personal devices.

**Q: Can I use MDM for iPhones instead?**
A: Yes. If you prefer MDM-enrolled iPhones, you can modify CA005 to require compliant device instead of app protection policy. The MAM approach in this repo is for organizations that prefer not to require device enrollment on iOS.

**Q: What are the placeholder GUIDs?**
A: Every policy uses `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` as a placeholder for group IDs. You must replace these with your actual Entra ID security group object IDs after importing.

**Q: How do I find my group's GUID?**
A: Go to Entra admin center → Identity → Groups → All groups → Click on the group → The Object ID is shown in the Overview blade.

**Q: What if I do not want all 22 policies?**
A: You can import only the policies you need. However, we recommend at minimum: CA001 (block legacy auth), CA002 (MFA all users), CA004 (compliant devices), and CA005 (iOS MAM).

**Q: Can I modify the policies after import?**
A: Absolutely. The imported policies are fully editable. Customize them to fit your organization. See the Customization guide.

## Troubleshooting

**Q: A policy shows "Not applied" in sign-in logs. Is it broken?**
A: Not necessarily. "Not applied" means the policy conditions were not met for that particular sign-in. For example, a policy targeting iOS will show as "Not applied" for a Windows sign-in.

**Q: I enabled a policy and users are locked out. What do I do?**
A: Use your emergency access (break-glass) accounts to sign in and change the policy back to Report-Only or Off. See the Troubleshooting guide.

**Q: The JSON import fails with an error. What should I check?**
A: Verify the JSON is valid (no syntax errors). Ensure you have the correct admin role. Try downloading the file again in case it was corrupted.

## Contributing

**Q: Can I contribute a new policy?**
A: Yes! See CONTRIBUTING.md for guidelines. New policies should include JSON, README, and NIS2 mapping.

**Q: I found a mistake in a policy. How do I report it?**
A: Open an issue on the GitHub repository with details of the error.
