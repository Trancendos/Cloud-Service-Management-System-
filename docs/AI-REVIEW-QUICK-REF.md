# AI Review Reports - Quick Reference

## 🚨 Important: Do NOT Convert to Issues

AI Code Review Reports are **automated PR comments** and should **NOT** be converted into GitHub issues.

## Why?

- ✅ They are informational feedback for PR authors
- ✅ They are tied to specific code changes
- ✅ They auto-resolve when PR is merged/closed
- ✅ Creating issues creates unnecessary noise

## What to Do Instead

### When you see an AI Review Report:

1. **Read it in the PR comments** where it belongs
2. **Address any findings** mentioned in the report
3. **Check workflow logs** for details
4. **Merge the PR** when all checks pass

### If Issues Were Already Created:

1. **Close them** as "not planned" or "duplicate"
2. **Reference the original PR** in closing comment
3. **Link to this guide** for future reference

## Report Types

### ✅ Success Report
```
✅ Great work! No issues found in this PR.
```
**Action:** None needed, proceed with PR review

### ⚠️ Issues Found Report
```
### Findings Summary
- 🔒 Security Issues: [count]
- ⚠️ Code Quality: [count]
- 💅 Style Issues: [count]
- 💡 Best Practices: [count]
```
**Action:** Review findings in workflow logs, address as needed

## Quick Decision Tree

```
See AI Code Review Report
    |
    ├─ In PR comments? ✅ Read and address in PR
    |
    └─ As an issue? ❌ Close issue, refer to PR
```

## Need Help?

- **Full Guide:** [docs/AI-REVIEW-REPORTS.md](AI-REVIEW-REPORTS.md)
- **Documentation:** [docs/README.md](README.md)
- **Workflows:** [.github/workflows/README.md](.github/workflows/README.md)

---

**Remember:** AI reports = PR comments, not issues! 🎯
