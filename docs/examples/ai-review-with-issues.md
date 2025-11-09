# Example: AI Code Review Report with Issues

This is an example of what an AI Code Review Report looks like when issues are detected.

---

## 🤖 AI Code Review Report

**Files Reviewed:** 3

⚠️ **Found 2 potential issue(s)** that may need attention.

### Code Analysis Results

Analyzing 3 changed file(s)...

#### Security Analysis
⚠️ Potential hardcoded credentials detected

#### Code Quality
ℹ️ Found TODO/FIXME comments

#### Style Consistency
✅ Basic style checks passed

#### Best Practices
✅ Following repository conventions

---
*Check the workflow logs for detailed findings and recommendations.*

**AI Review Capabilities:**
- ✅ Security vulnerability detection
- ✅ Code quality analysis
- ✅ Style consistency checks
- ✅ Best practices validation

---

## What This Means

When you see this report with warnings, you should:

1. **Review the Security Analysis**: Check if any credentials need to be moved to environment variables or secrets
2. **Check Code Quality Issues**: Review TODO/FIXME comments and consider completing or removing them before merging
3. **View Detailed Logs**: Click on the workflow run in the Actions tab to see exactly which files and lines triggered warnings
4. **Make Fixes**: Address the issues found and push new commits to update the PR

Remember:
- Some findings may be false positives - use your judgment
- Not all issues require immediate action
- The AI review is advisory, complementing human review
- Check the specific workflow logs for file names and line numbers
