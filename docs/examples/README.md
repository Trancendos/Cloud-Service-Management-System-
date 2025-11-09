# AI Code Review Report Examples

This directory contains example AI Code Review Reports to help you understand what to expect when the automated code review runs on your pull requests.

## Available Examples

### [Clean Review Example](ai-review-clean.md)
Shows what a report looks like when no issues are found. This is what you'll see when:
- No security vulnerabilities detected
- No hardcoded credentials found
- Code quality checks pass
- Style is consistent

### [Review with Issues Example](ai-review-with-issues.md)
Shows what a report looks like when the AI bot detects potential issues. This example demonstrates:
- How security warnings are displayed
- Code quality issue reporting
- How to interpret the findings
- What actions to take

## How to Use These Examples

1. **Before opening a PR**: Review these examples to understand what the bot checks for
2. **After receiving a report**: Compare your report to these examples to understand the findings
3. **For new contributors**: Use these to learn what the automated review expects

## Real Reports

To see real AI Code Review Reports in action:
- Check PR #8 for a live example
- View the [Actions tab](../../../actions/workflows/ai-code-review.yml) for detailed logs
- Any PR with code changes will automatically trigger the AI review

## Learn More

See the [AI Code Review Reports Guide](../AI-CODE-REVIEW-REPORTS.md) for complete documentation about:
- Report formats and structure
- What the AI reviews
- Customization options
- Best practices
