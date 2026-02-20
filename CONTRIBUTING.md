# Contributing to NIS2 Conditional Access Policies

Thank you for your interest in contributing to this project! Every contribution helps IT admins around the world secure their Microsoft 365 environments.

## How to Contribute

### Reporting Issues

If you find a problem with a policy, documentation, or JSON file:

1. Check existing [issues](../../issues) to avoid duplicates
2. Open a new issue using the appropriate template
3. Include as much detail as possible: what you expected, what happened, and steps to reproduce

### Suggesting New Policies

Have an idea for a new Conditional Access policy?

1. Open an issue with the title prefix `[Policy Request]`
2. Describe the security scenario the policy addresses
3. Explain which NIS2 Article 21 subsection it maps to
4. If possible, provide a draft JSON configuration

### Improving Documentation

Documentation improvements are always welcome:

1. Fix typos, clarify instructions, or add missing details
2. Add screenshots or diagrams that help explain concepts
3. Translate documentation for non-English speakers
4. Improve the Getting Started guide based on your experience

### Submitting Pull Requests

1. **Fork** the repository
2. **Create a branch** with a descriptive name: `feature/ca023-new-policy` or `fix/ca005-typo`
3. **Make your changes** following the standards below
4. **Test your JSON** files are valid (use `jq . < yourfile.json`)
5. **Submit a pull request** with a clear description of your changes

## Standards

### Policy Naming Convention

- Conditional Access: `CA###: Description — Scope`
- App Protection: `MAM###: Description`
- Global Secure Access: `GSA###: Description`
- Named Locations: `NL###: Description`

### JSON Formatting

- Pretty-printed with **4-space indentation**
- UTF-8 encoding
- No comments in JSON files (use the companion README.md for explanations)
- All placeholder GUIDs use the format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

### Documentation Requirements

Every new policy must include:

- A **README.md** in its folder explaining what it does in plain English
- **NIS2 mapping** to the relevant Article 21 subsection
- **Import instructions** with GUI navigation paths
- **Placeholder GUID documentation** listing what needs to be replaced
- **End-user impact** description so admins can prepare their helpdesk

### Safety Requirements

- All policies **must** ship in `enabledForReportingButNotEnforced` (Report-Only) state
- All blocking/granting policies **must** exclude the emergency access group
- No tenant-specific values — everything must use replaceable placeholders

## Code of Conduct

We are committed to providing a welcoming and inclusive experience for everyone. Please be respectful, constructive, and patient in all interactions.

### Our Standards

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community

### Unacceptable Behavior

- Trolling, insulting/derogatory comments, and personal attacks
- Public or private harassment
- Publishing others' private information without permission

## Review Process

1. All PRs are reviewed by at least one maintainer
2. JSON files are validated for correct schema compliance
3. Documentation is reviewed for clarity and completeness
4. NIS2 mappings are verified for accuracy

## Questions?

Open an issue with the `[Question]` prefix and we will be happy to help.

Thank you for making Microsoft 365 environments more secure!
