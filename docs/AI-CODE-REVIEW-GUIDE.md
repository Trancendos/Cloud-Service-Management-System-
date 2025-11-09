# AI Code Review Bot Guide

## Overview

The AI Code Review bot automatically analyzes pull requests and posts review comments with findings. This guide explains how to work with these automated reviews.

## Understanding AI Review Comments

AI Code Review comments are identified by:
- 🤖 emoji in the title
- Hidden HTML marker `<!-- ai-code-review-bot -->`
- Clear labeling as "automated review comment"

### Example Review Comment

```markdown
## 🤖 AI Code Review Report

**Files Reviewed:** 5

✅ **Great work!** No issues found in this PR.

---
*Check the workflow logs for detailed findings and recommendations.*

**AI Review Capabilities:**
- ✅ Security vulnerability detection
- ✅ Code quality analysis
- ✅ Style consistency checks
- ✅ Best practices validation

> **Note:** This is an automated review comment. It should not be converted into an issue.
```

## Important Guidelines

### ❌ DO NOT Create Issues from Bot Comments

AI review comments are **informational status updates**, not actionable issues. They should:
- Remain as PR comments
- Be addressed within the PR itself
- Not be converted to separate issue tickets

### ✅ DO Address Findings Directly

When the AI review identifies issues:
1. Review the findings in the PR comment
2. Make necessary code changes in the same PR
3. Push updates to trigger a new review
4. Reference specific findings in your commit messages

## Review Capabilities

The AI Code Review bot checks for:

### Security Vulnerabilities
- Hardcoded credentials (passwords, API keys, tokens)
- Potential security anti-patterns
- Sensitive data exposure risks

### Code Quality
- TODO/FIXME comments
- Code complexity issues
- Dead code detection
- File size concerns

### Style Consistency
- Basic formatting checks
- Naming conventions
- Code organization

### Best Practices
- Error handling patterns
- Action version pinning
- Documentation completeness

## Workflow Details

The AI Code Review workflow runs on:
- Pull request opened
- Pull request synchronized (new commits)
- Pull request reopened

See `.github/workflows/ai-code-review.yml` for implementation details.

## Troubleshooting

### Why do I see multiple review comments?

Each push to a PR branch triggers a new review. This is intentional to provide feedback on the latest changes.

### Can I disable the AI review?

Yes, you can temporarily disable it by:
1. Editing `.github/workflows/ai-code-review.yml`
2. Adding a condition to skip certain PRs
3. Or commenting out the workflow trigger

### How do I improve review accuracy?

The AI review uses pattern-based analysis. To improve results:
- Keep files focused and reasonably sized
- Follow existing code conventions
- Use clear, descriptive names
- Add comments for complex logic

## Related Workflows

- `ai-data-checker.yml` - Validates data files
- `ai-workflow-validator.yml` - Checks workflow syntax
- `ai-debugging-assistant.yml` - Helps debug failures

## Questions?

For issues with the AI Code Review workflow itself, please:
1. Check the workflow logs in the Actions tab
2. Review this documentation
3. Open a new issue with the `workflow` label
