# AI Code Review Workflow

## Overview

The AI Code Review workflow provides automated code analysis for pull requests, helping maintain code quality, security, and best practices across the repository.

## Features

### 🔒 Security Vulnerability Detection
- Detects hardcoded secrets and credentials
- Identifies potential SQL injection risks
- Flags insecure coding patterns

### 📊 Code Quality Analysis
- Identifies TODO/FIXME comments that need attention
- Detects code smells and anti-patterns
- Validates code structure and organization

### 🎨 Style Consistency Checks
- Detects debugging statements (console.log, print)
- Ensures consistent code formatting
- Validates naming conventions

### ✨ Best Practices Validation
- Checks for proper error handling
- Validates shell script safety (set -e usage)
- Ensures adherence to coding standards

## How It Works

1. **Trigger**: Automatically runs when a pull request is opened, updated, or reopened
2. **Analysis**: Scans all changed code files for issues
3. **Reporting**: Posts a detailed review comment on the PR
4. **Updates**: Updates the same comment on subsequent commits to avoid spam

## Workflow Configuration

### Trigger Events

```yaml
on:
  pull_request:
    types:
      - opened
      - synchronize
      - reopened
  pull_request_review:
    types:
      - submitted
```

### Permissions Required

```yaml
permissions:
  contents: read
  pull-requests: write
  issues: write
```

## Usage

The workflow runs automatically - no manual intervention required!

### Manual Trigger

You can also manually trigger the workflow from the Actions tab for testing purposes.

### Viewing Results

1. **PR Comment**: A formatted review report is posted as a comment on your PR
2. **Workflow Logs**: Detailed analysis results are available in the workflow run logs
3. **Job Summary**: A quick summary is available in the GitHub Actions job summary

## Review Report Format

### No Issues Found

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
```

### Issues Found

```markdown
## 🤖 AI Code Review Report

**Files Reviewed:** 5

⚠️ **Issues Found:** 8

### Issue Breakdown
- 🔒 Security: 2
- 📊 Code Quality: 3
- 🎨 Style: 2
- ✨ Best Practices: 1

---

### 💡 Recommendations

Please review the workflow logs for detailed information about each issue.

**Next Steps:**
1. Review the identified issues in the workflow logs
2. Address critical security and quality concerns
3. Consider style and best practice improvements

---
*Check the workflow logs for detailed findings and recommendations.*

**AI Review Capabilities:**
- ✅ Security vulnerability detection
- ✅ Code quality analysis
- ✅ Style consistency checks
- ✅ Best practices validation
```

## Supported File Types

The workflow analyzes the following file types:
- JavaScript/TypeScript (`.js`, `.ts`)
- Python (`.py`)
- Java (`.java`)
- Go (`.go`)
- Ruby (`.rb`)
- PHP (`.php`)
- C# (`.cs`)
- C/C++ (`.cpp`, `.c`, `.h`)
- YAML (`.yml`, `.yaml`)
- JSON (`.json`)
- Shell scripts (`.sh`)

## Customization

### Adding New Checks

To add new analysis rules, edit the "Analyze code quality" step in `.github/workflows/ai-code-review.yml`:

```bash
# Example: Add a new security check
if grep -qE 'dangerous_function' "$file" 2>/dev/null; then
  ((security_issues++))
  echo "⚠️ Dangerous function usage in $file"
fi
```

### Excluding Files

To exclude certain files or patterns from analysis, modify the changed files filter:

```bash
# Exclude test files and documentation
code_files=$(echo "$changed_files" | grep -E '\.(js|ts|py)$' | grep -v -E '(test|spec|\.md)' || true)
```

### Adjusting Severity

You can categorize issues differently by modifying which counter is incremented:

```bash
# Change from style issue to quality issue
if grep -qE 'console\.log' "$file" 2>/dev/null; then
  ((quality_issues++))  # Changed from style_issues
fi
```

## Integration with Other Workflows

The AI Code Review workflow complements other quality checks:

- **Works alongside**: Linting workflows, test suites, security scanners
- **Non-blocking**: Does not prevent PR merging
- **Informative**: Provides guidance without enforcing strict rules

## Best Practices

1. **Review the findings**: Don't ignore the automated feedback
2. **Address security issues first**: Prioritize security and critical quality issues
3. **Consider style suggestions**: Maintain consistency across the codebase
4. **Keep improving**: Add new checks as you identify patterns to avoid

## Troubleshooting

### Comment Not Posted

**Issue**: The review comment doesn't appear on the PR.

**Solutions**:
- Check that the workflow has `pull-requests: write` permission
- Verify the workflow run completed successfully
- Check for GitHub API rate limiting

### Incorrect Issue Count

**Issue**: The reported issue count doesn't match expectations.

**Solutions**:
- Review the workflow logs to see which files were analyzed
- Verify the grep patterns match your code style
- Adjust the analysis rules for your specific codebase

### Workflow Timeout

**Issue**: The workflow times out on large PRs.

**Solutions**:
- Increase the `timeout-minutes` value
- Optimize the analysis scripts
- Consider analyzing only specific file types

## Future Enhancements

Planned improvements:
- Integration with external AI services (OpenAI, Claude)
- More sophisticated code analysis patterns
- Language-specific deep analysis
- Auto-fix suggestions
- Configurable severity levels
- Custom rule definitions via config file

## Contributing

To improve the AI Code Review workflow:

1. Test your changes on a feature branch
2. Add new analysis patterns carefully
3. Update this documentation
4. Submit a pull request

## Related Documentation

- [Workflows README](.github/workflows/README.md)
- [Notifications Setup](NOTIFICATIONS.md)
- [Contributing Guidelines](../../README.md)
