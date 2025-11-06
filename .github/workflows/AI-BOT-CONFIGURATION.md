# AI/Bot Configuration Guide

This guide provides detailed configuration instructions for the AI/bot integration system.

## 🎯 Quick Start

### 1. Enable AI Bots (Already Done!)

All AI bots are automatically enabled once the workflow files are present in `.github/workflows/`:
- ✅ `ai-workflow-validator.yml`
- ✅ `ai-data-checker.yml`
- ✅ `ai-code-review.yml`
- ✅ `ai-debugging-assistant.yml`

### 2. Verify Installation

Check that workflows are active:
```bash
# List all workflows
ls .github/workflows/ai-*.yml

# View workflow status in GitHub
# Navigate to: Repository → Actions tab
```

### 3. Test AI Bots

Trigger a test run:
1. Go to **Actions** tab
2. Select any AI workflow
3. Click **Run workflow**
4. Observe the results

---

## 🔧 Configuration Options

### AI Workflow Validator

**File**: `.github/workflows/ai-workflow-validator.yml`

#### Trigger Configuration
```yaml
on:
  pull_request:
    paths:
      - '.github/workflows/*.yml'
      - '.github/workflows/*.yaml'
  workflow_dispatch:
  push:
    branches:
      - main  # Add more branches if needed
```

#### Custom Validation Rules

Edit the validation script section to add custom rules:

```python
def _check_custom_rule(self, workflow, filepath):
    """Add your custom validation logic"""
    # Example: Require specific runner
    for job_name, job_config in workflow.get('jobs', {}).items():
        if job_config.get('runs-on') != 'ubuntu-latest':
            self.warnings.append(
                f"⚠️ {filepath}: Job '{job_name}' should use ubuntu-latest"
            )
```

#### Validation Strictness

Adjust what counts as an error vs warning:
- **Issues** (❌): Critical problems that must be fixed
- **Warnings** (⚠️): Important suggestions
- **Suggestions** (💡): Nice-to-have improvements

---

### AI Data Checker

**File**: `.github/workflows/ai-data-checker.yml`

#### File Type Configuration

Add more file types to check:
```python
# In the scan_repository() method
for toml_file in Path('.').rglob('*.toml'):
    if '.git' not in str(toml_file):
        self.check_toml_file(toml_file)
```

#### Custom Data Validation

Add schema validation:
```python
def check_json_file(self, filepath):
    try:
        with open(filepath, 'r') as f:
            data = json.load(f)
        
        # Add custom schema validation
        if filepath.name == 'config.json':
            self._validate_config_schema(data, filepath)
    except json.JSONDecodeError as e:
        self.results['invalid'].append(f"❌ {filepath}: Invalid JSON - {e}")
```

#### Excluded Directories

Add directories to exclude from scanning:
```python
excluded_dirs = ['.git', 'node_modules', 'dist', 'build', '__pycache__']
if any(excluded in str(json_file) for excluded in excluded_dirs):
    continue
```

---

### AI Code Review Bot

**File**: `.github/workflows/ai-code-review.yml`

#### Review Scope

Configure which file types to review:
```python
# Add more language support
elif ext in ['.go', '.rs', '.rb']:
    self.review_golang_file(file)  # Implement custom reviewers
```

#### Custom Security Rules

Add project-specific security checks:
```python
def review_custom_security(self, filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Custom pattern detection
    if re.search(r'your_custom_pattern', content):
        self.findings['security'].append(
            f"🔒 {filepath}: Custom security issue detected"
        )
```

#### Code Quality Thresholds

Adjust quality thresholds:
```python
# Customize line count threshold
if len(lines) > 300:  # Changed from 500
    self.findings['quality'].append(
        f"📏 {filepath}: File exceeds 300 lines"
    )

# Add complexity checks
if self._calculate_complexity(content) > 10:
    self.findings['quality'].append(
        f"🔄 {filepath}: High cyclomatic complexity"
    )
```

---

### AI Debugging Assistant

**File**: `.github/workflows/ai-debugging-assistant.yml`

#### Workflow Failure Analysis

Add custom failure patterns:
```python
common_solutions = {
    'custom_error': {
        'description': 'Custom error pattern',
        'solutions': [
            '🔧 Solution 1',
            '🔧 Solution 2'
        ]
    }
}
```

#### Issue Labeling

Configure automatic issue triage:
```yaml
- name: Auto-label Issues
  if: github.event_name == 'issues'
  uses: actions/github-script@v7
  with:
    script: |
      const title = context.payload.issue.title.toLowerCase();
      const labels = [];
      
      if (title.includes('workflow')) labels.push('workflows');
      if (title.includes('security')) labels.push('security');
      
      await github.rest.issues.addLabels({
        issue_number: context.issue.number,
        owner: context.repo.owner,
        repo: context.repo.repo,
        labels: labels
      });
```

---

## 🔐 Permissions Configuration

### Required Permissions

Each workflow has specific permission requirements:

#### Workflow Validator
```yaml
permissions:
  contents: read       # Read workflow files
  pull-requests: write # Post PR comments
  issues: write        # Create issues for problems
```

#### Data Checker
```yaml
permissions:
  contents: read       # Read data files
  pull-requests: write # Post validation results
```

#### Code Review Bot
```yaml
permissions:
  contents: read       # Read code
  pull-requests: write # Post review comments
```

#### Debugging Assistant
```yaml
permissions:
  contents: read       # Read repository
  issues: write        # Comment on issues
  actions: read        # Read workflow runs
```

### Adjusting Permissions

To restrict permissions:
```yaml
permissions:
  contents: read  # Remove write access
  # Remove other permissions as needed
```

To expand permissions:
```yaml
permissions:
  contents: write      # Allow file modifications
  pull-requests: write # Allow PR updates
  issues: write        # Allow issue creation
```

---

## 🎨 Customizing Reports

### PR Comment Format

Edit comment templates in each workflow:

```javascript
// In the GitHub Script action
let comment = '## 🤖 Custom AI Report\n\n';
comment += `**Custom Metrics:**\n`;
comment += `- Metric 1: ${value1}\n`;
comment += `- Metric 2: ${value2}\n`;

// Add custom sections
comment += '\n### Custom Section\n';
comment += 'Your custom content here\n';
```

### Console Output Format

Customize the terminal output:
```python
def print_report(self):
    """Custom report format"""
    print("\n" + "🎨 CUSTOM REPORT ".center(70, "="))
    print(f"Analysis Complete: {datetime.now()}")
    print("="*70)
    # Add your custom formatting
```

---

## 🔄 Integration with CI/CD

### Branch Protection

Require AI checks before merging:
1. Go to **Settings** → **Branches**
2. Add branch protection rule for `main`
3. Enable "Require status checks to pass"
4. Select AI bot workflows:
   - `AI Workflow Validator`
   - `AI Data Checker`
   - `AI Code Review Bot`

### Status Checks

Configure workflows to report status:
```yaml
- name: Report Status
  if: failure()
  run: |
    echo "::error::AI validation failed"
    exit 1
```

### Required Reviews

Combine AI bots with human reviews:
```yaml
# In branch protection settings
Required reviews: 1
Required status checks:
  - AI Workflow Validator
  - AI Code Review Bot
```

---

## 📊 Advanced Configuration

### Performance Tuning

#### Caching Dependencies
```yaml
- name: Cache Python dependencies
  uses: actions/cache@v4
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
```

#### Parallel Execution
```yaml
jobs:
  validate:
    strategy:
      matrix:
        check: [workflows, data, code]
    # Run checks in parallel
```

#### Timeout Configuration
```yaml
jobs:
  ai-check:
    timeout-minutes: 10  # Adjust as needed
```

---

### Multi-Repository Setup

#### Organization-Wide Configuration

Create a `.github` repository in your organization:
```
organization/.github/
  workflows/
    ai-workflow-validator.yml
    ai-data-checker.yml
    ai-code-review.yml
    ai-debugging-assistant.yml
```

These will apply to all repositories without their own workflows.

#### Shared Configuration

Create a shared config file:
```yaml
# .github/ai-bot-config.yml
validation:
  strictness: high
  auto_fix: false
  excluded_files:
    - '*.test.js'
    - 'generated/*'

code_review:
  languages:
    - python
    - javascript
    - go
  max_file_size: 1000
```

Load config in workflows:
```python
import yaml

with open('.github/ai-bot-config.yml', 'r') as f:
    config = yaml.safe_load(f)
```

---

## 🧪 Testing Configuration

### Test Custom Rules

Create a test branch:
```bash
git checkout -b test-ai-bots
# Make changes to trigger AI bots
git add .
git commit -m "Test AI bot configuration"
git push origin test-ai-bots
# Create PR to test
```

### Validate Changes

1. Open PR from test branch
2. Check AI bot comments
3. Review workflow logs
4. Adjust configuration as needed
5. Close PR when satisfied

---

## 🚨 Troubleshooting Configuration

### Common Issues

#### 1. Workflow Not Triggering
**Solution**: Check trigger configuration
```yaml
on:
  pull_request:
    paths:
      - '**/*.py'  # Ensure paths match your files
```

#### 2. Permission Errors
**Solution**: Grant required permissions
```yaml
permissions:
  contents: read
  pull-requests: write
```

#### 3. Python Errors
**Solution**: Add missing dependencies
```yaml
- name: Install dependencies
  run: |
    pip install pyyaml jsonschema validators bandit pylint
```

#### 4. No PR Comments
**Check**:
- Workflow has `pull-requests: write` permission
- PR is not from a fork (requires manual approval)
- Workflow completed successfully

---

## 📝 Configuration Examples

### Example 1: Strict Mode

High-security environment configuration:
```yaml
# Fail on any issue
- name: Strict Validation
  run: |
    if [ "${{ steps.validate.outputs.issue_count }}" != "0" ]; then
      echo "::error::Validation failed"
      exit 1
    fi
```

### Example 2: Warning Only

Non-blocking suggestions:
```yaml
# Never fail, only warn
- name: Warning Mode
  run: |
    echo "::warning::Found ${{ steps.validate.outputs.issue_count }} issues"
    exit 0
```

### Example 3: Auto-fix

Automatically apply fixes:
```yaml
- name: Auto-fix Issues
  if: steps.validate.outputs.issue_count != '0'
  run: |
    # Apply automatic fixes
    python scripts/auto-fix.py
    
    # Commit changes
    git config user.name "AI Bot"
    git config user.email "ai-bot@example.com"
    git add .
    git commit -m "chore: AI bot auto-fixes"
    git push
```

---

## 🎓 Best Practices

### 1. Start Simple
- Enable AI bots with default configuration
- Monitor results for a few weeks
- Gradually add custom rules

### 2. Iterate and Improve
- Review false positives
- Adjust sensitivity
- Add project-specific rules

### 3. Document Customizations
- Comment custom rules
- Update this guide with changes
- Share knowledge with team

### 4. Monitor Performance
- Track workflow execution time
- Optimize slow checks
- Use caching effectively

---

## 📞 Getting Help

### Configuration Support
- Check workflow logs for errors
- Review this guide thoroughly
- Consult GitHub Actions documentation
- Open an issue with the `ai-bot` label

### Sharing Configurations
- Create discussions for useful patterns
- Submit PRs to improve defaults
- Share organization-specific rules

---

**Configuration Guide Version**: 1.0.0
**Last Updated**: November 2025
