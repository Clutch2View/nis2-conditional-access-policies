# Troubleshooting

Common issues and solutions when deploying these Conditional Access policies.

## Import Issues

### "The policy could not be imported"
- Verify the JSON file is valid (no syntax errors, no trailing commas)
- Ensure you are importing from the correct location in Entra admin center
- Check that your admin role has permission to create CA policies

### "Group not found" after import
- Placeholder GUIDs (`xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`) need to be replaced with your actual group IDs
- Open the imported policy, update the group references, and save

### Import button not visible
- Ensure you are on the Conditional Access Policies page: **Protection** → **Conditional Access** → **Policies**
- The Import feature requires Conditional Access Administrator or Global Administrator role
- Check if the feature is available in your tenant (may require recent Entra ID updates)

## MFA Issues

### Users prompted for MFA on every sign-in
- Check CA016 (Sign-in Frequency) settings — the default is 12 hours
- Verify the user is on a compliant/managed device
- Check if persistent browser sessions are configured

### Users cannot register for MFA
- Ensure users are not blocked by CA policies during MFA registration
- Users may need to be temporarily excluded from MFA policies during initial registration
- Use the MFA registration policy in Entra ID Protection

### Service accounts being prompted for MFA
- Add service accounts to the **CA-ServiceAccounts** group
- Verify the group is in the exclude list for CA002
- Consider using managed identities instead of service accounts where possible

## Device Compliance Issues

### Windows device shows as non-compliant
- Verify the device is enrolled in Intune
- Check Intune compliance policies are assigned
- Allow time for compliance evaluation (can take up to 24 hours)
- On the device: Settings → Accounts → Access work or school → Check sync status

### macOS device shows as non-compliant
- Verify the MDM profile is installed
- Check that all compliance policy requirements are met (OS version, encryption, etc.)
- Allow time for the compliance state to sync

### iPhone/iPad blocked despite MAM policy
- Verify MAM001 (iOS App Protection Policy) is deployed and assigned
- Ensure the user is using a managed app (e.g., Outlook, Teams)
- Wait up to 30 minutes for the app protection policy to apply
- User may need to close and reopen the app
- Verify CA005 is configured correctly with "Require app protection policy" grant

## Policy Conflicts

### Multiple policies blocking access
- Use the **What If** tool to diagnose: **Protection** → **Conditional Access** → **What If**
- Check sign-in logs for the specific failure reason
- Policies are evaluated in combination — all applicable policies must be satisfied

### Users blocked unexpectedly
1. Check sign-in logs: **Identity** → **Monitoring & health** → **Sign-in logs**
2. Find the blocked sign-in entry
3. Click on it → **Conditional Access** tab
4. Identify which policy caused the block
5. Switch that policy to Report-Only while you investigate

## Emergency Lockout

### Admin locked out by Conditional Access
1. Use an **emergency access account** (break-glass account) to sign in
2. These accounts should be excluded from all CA policies
3. Disable or modify the problematic policy
4. If break-glass accounts are also locked out, contact Microsoft Support

### All users locked out
1. Sign in with an emergency access account
2. Disable all recently enabled policies (change to Report-Only or Off)
3. Investigate the root cause in sign-in logs
4. Re-enable policies one at a time after fixing the issue

## Report-Only Mode Issues

### Policies showing "Not applied" in Report-Only
- This means the policy conditions were not met for that sign-in
- Verify the user, app, and device conditions match the policy configuration
- This is expected for policies targeting specific platforms or risk levels

### Large number of "Report-only: Failure" entries
- This indicates many users would be blocked if the policy were enforced
- Review the failures to understand the impact before enabling
- Consider adjusting the policy scope or creating exceptions

## Performance Issues

### Slow sign-in times
- Too many concurrent CA policies can increase evaluation time
- Review whether all policies are necessary
- Consider consolidating similar policies

### Conditional Access evaluation timeouts
- Rare but can occur with very complex policy sets
- Simplify conditions where possible
- Contact Microsoft Support if persistent

## Getting Help

If you cannot resolve an issue:

1. Check the [FAQ](FAQ.md) for common questions
2. Review [Microsoft's CA troubleshooting guide](https://learn.microsoft.com/en-us/entra/identity/conditional-access/troubleshoot-conditional-access)
3. Use the **What If** tool for diagnosis
4. Open an issue on this repository with details of your problem
5. Contact Microsoft Support for tenant-specific issues
