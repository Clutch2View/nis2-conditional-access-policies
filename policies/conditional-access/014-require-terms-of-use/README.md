# CA014: Require Terms of Use

## What This Policy Does

This policy requires all users to accept the organization's **Terms of Use (ToU)** before accessing any cloud application. This creates a documented audit trail of user acceptance, which is essential for NIS2 compliance and legal requirements. Users who have not accepted (or need to re-accept after an update) are presented with the ToU document before gaining access.

---

## 📋 NIS2 Mapping

| NIS2 Article 21 Reference | Description |
|---|---|
| Article 21(2)(g) | Basic cyber hygiene practices and security training |
| Article 21(2)(i) | Human resources security — documented user acknowledgment |

---

## Placeholder GUIDs

| Placeholder | Represents |
|---|---|
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in excludeGroups) | Emergency Access Accounts group |
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (in termsOfUse) | Terms of Use document ID — must be created first |

> ⚠️ **WARNING**: You must create a Terms of Use document in Entra ID before this policy will work. Replace both placeholder GUIDs.

---

## Prerequisites

- Terms of Use document created in Entra ID (**Protection** → **Conditional Access** → **Terms of use**)
- Emergency Access Accounts group exists

---

## Import Instructions

1. First, create a Terms of Use document:
   - Go to **Protection** → **Conditional Access** → **Terms of use**
   - Click **+ New terms**
   - Upload your PDF document, configure display settings
   - Note the Terms of Use ID
2. Then create the CA policy:
   - Navigate to **Protection** → **Conditional Access** → **Policies**
   - Click **+ New policy**
   - Configure:
     - **Name**: `CA014: Require Terms of Use`
     - **Users**: Include **All users**, Exclude **Emergency Access Accounts** group
     - **Target resources**: **All cloud apps**
     - **Grant**: Select your **Terms of Use** document
   - Set to **Report-only** mode
   - Click **Create**

---

## What Does This Look Like for the End User?

- **First-time sign-in**: User sees the Terms of Use document and must accept before proceeding.
- **After acceptance**: No further prompts until the ToU is updated or re-acceptance is required.
- **Updated ToU**: Users are prompted to review and accept the new version.

---

## Dependencies

| Policy | Reason |
|---|---|
| None | This policy is independent but should be deployed after the baseline policies |

---

## Common Issues & Troubleshooting

| Issue | Resolution |
|---|---|
| ToU not appearing | Verify the Terms of Use document ID is correct in the policy |
| Users prompted repeatedly | Check the ToU re-acceptance settings — set an appropriate interval |
| Mobile users cannot see ToU | Ensure the PDF is mobile-friendly |

---

## 💡 Tips

- Set ToU to require re-acceptance annually or when the document is updated.
- Use different ToU documents for different regions if needed (EMEA, APAC, USA).
- Review the ToU acceptance report for compliance auditing.

---

## Related Policies

- **CA019**: Restrict Guest Access (guests may need separate ToU)
