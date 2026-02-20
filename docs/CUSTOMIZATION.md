# Customization Guide

These policies are designed as a starting point. Every organization is different, and you should tailor these policies to fit your specific needs.

## Common Customizations

### Adjusting Sign-In Frequency (CA016)
The default sign-in frequency is set to 12 hours. You may want to change this:
- **Shorter (4-8 hours)**: For high-security environments
- **Longer (24 hours)**: For better user experience with lower risk tolerance
- Edit the policy → Session controls → Sign-in frequency → Change the hours value

### Modifying Blocked Countries (CA021)
Edit the Blocked Countries named location to add or remove countries based on:
- Where your organization operates
- Your threat intelligence
- Where your employees travel

### Adjusting MFA Requirements
- **CA002** requires MFA for all users — you can exclude specific groups temporarily during rollout
- **CA012** requires phishing-resistant MFA for admins — adjust the required authentication strength based on your deployed methods

### Modifying MAM Policy Settings
- **PIN length**: Increase from 6 to 8 digits for higher security
- **Offline grace period**: Adjust based on your users' connectivity patterns
- **Minimum OS version**: Update as new OS versions are released
- **App list**: Add or remove apps from the managed app list

### Customizing Session Controls (CA015)
- App-enforced restrictions can be fine-tuned per application
- Configure SharePoint and Exchange Online access policies to match your data sensitivity

## Adding New Policies

To create additional policies:
1. Use an existing policy JSON as a template
2. Modify the conditions, grant controls, and session controls
3. Ensure the policy is in Report-Only mode
4. Add emergency access group exclusion
5. Create a README documenting the policy
6. Map to NIS2 Article 21 if applicable

## Removing Policies

If a policy does not apply to your organization:
- Simply do not import it
- Or import it and leave it in Report-Only mode for visibility
- Document why the policy was excluded for audit purposes

## Integrating with Existing Policies

If you already have Conditional Access policies:
1. Review your existing policies for overlap with these policies
2. Use the What If tool to check for conflicts
3. Consider renaming existing policies to follow the CA### naming convention
4. Import new policies in Report-Only mode alongside existing policies
5. Resolve any conflicts before enabling

## Advanced Customizations

### Targeting Specific Apps Instead of All Cloud Apps
Some policies target All cloud apps. You can narrow the scope:
- Edit the policy → Cloud apps or actions → Select specific apps
- Useful for organizations that want different controls for different applications

### Using Authentication Contexts
For advanced scenarios, you can use authentication contexts to apply step-up authentication for sensitive actions within applications.

### Combining with Intune Compliance Policies
Create more granular compliance requirements:
- Require specific antivirus products
- Require minimum patch levels
- Require disk encryption verification
- Require specific security configurations

## Testing Changes

Always test customizations using:
1. **Report-Only mode**: See the impact without enforcing
2. **What If tool**: Simulate specific user scenarios
3. **Sign-in logs**: Monitor actual authentication events
4. **Pilot groups**: Target a small group of test users before broad rollout
