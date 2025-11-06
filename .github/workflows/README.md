# GitHub Actions Workflows

This directory contains GitHub Actions workflows for the Cloud Service Management System.

## Workflows

### 1. Auto-fix Deprecated Actions (`auto-fix-deprecated-actions.yml`)

**Purpose**: Automatically detects and updates deprecated GitHub Actions to their latest versions.

**Triggers**:
- **Schedule**: Runs weekly every Monday at 9:00 AM UTC
- **Manual**: Can be triggered manually via workflow_dispatch
- **On Changes**: Runs when workflow files are modified

**What It Does**:
1. Scans all workflow files in `.github/workflows/`
2. Detects deprecated action versions:
   - `actions/cache@v1` or `v2` → `actions/cache@v4`
   - `actions/checkout@v1` or `v2` → `actions/checkout@v4`
   - `actions/setup-node@v1` or `v2` → `actions/setup-node@v4`
   - `actions/setup-python@v1` or `v2` → `actions/setup-python@v5`
3. Automatically creates a pull request with the updates

**Benefits**:
- ✅ Ensures workflows use secure, up-to-date actions
- ✅ Prevents breaking changes from deprecated actions
- ✅ Reduces manual maintenance burden
- ✅ Maintains compliance with GitHub Actions best practices

### 2. Example CI with Cache (`example-ci.yml`)

**Purpose**: Demonstrates proper usage of `actions/cache@v4` and other modern actions.

**Features**:
- Uses `actions/cache@v4` for dependency caching
- Uses `actions/checkout@v4` for repository checkout
- Uses `actions/setup-node@v4` for Node.js setup
- Provides a template for CI workflows

---

## 🤖 AI/Bot Integration Workflows

The Cloud Service Management System includes comprehensive AI/bot capabilities for automated analysis and assistance. These intelligent workflows provide data validation, workflow checks, code review, and debugging support.

### 3. AI Workflow Validator (`ai-workflow-validator.yml`)

**Purpose**: Automatically validates GitHub Actions workflow files using AI-powered analysis.

**Triggers**:
- Pull requests modifying workflow files
- Push to main branch (workflow files)
- Manual dispatch

**Key Features**:
- ✅ YAML syntax validation
- 🔒 Security best practices checking
- ⚡ Performance optimization suggestions
- 💡 Best practices recommendations
- 📋 Automated PR comments with findings

### 4. AI Data Checker (`ai-data-checker.yml`)

**Purpose**: Validates data files (JSON, YAML, Markdown) with intelligent content analysis.

**Triggers**:
- Pull requests with data file changes
- Push to main branch
- Manual dispatch

**Key Features**:
- ✅ JSON/YAML syntax validation
- 🔍 Content analysis and validation
- 🔒 Security checks for sensitive data
- 📝 Markdown link validation
- 💡 Data structure recommendations

### 5. AI Code Review Bot (`ai-code-review.yml`)

**Purpose**: Automated code review with security, quality, and style analysis.

**Triggers**:
- Pull requests (opened, updated, reopened)
- Manual dispatch

**Key Features**:
- 🔒 Security vulnerability detection
- ⚠️ Code quality analysis
- 💅 Style consistency checks
- 💡 Best practices validation
- 🌐 Multi-language support (Python, JavaScript, Shell, YAML)

### 6. AI Debugging Assistant (`ai-debugging-assistant.yml`)

**Purpose**: Intelligent debugging assistance for failed workflows and issues.

**Triggers**:
- Workflow failures (any workflow)
- New issues opened or labeled as 'bug'
- Manual dispatch

**Key Features**:
- 🔍 Automatic failure analysis
- 💡 Contextual debugging suggestions
- 📋 Common issue pattern matching
- 🤖 Automated issue triage
- 📊 Smart debugging recommendations

### 📚 AI/Bot Documentation

For comprehensive documentation on AI/bot integration, see:
- **[AI-BOT-INTEGRATION.md](./AI-BOT-INTEGRATION.md)** - Complete guide to AI/bot capabilities
- **[AI-BOT-CONFIGURATION.md](./AI-BOT-CONFIGURATION.md)** - Configuration and customization guide

---
### 3. Checkpoint Workflow with Dummy Data (`checkpoint-workflow.yml`)

**Purpose**: Validates workflow operations using dummy data and simulated service accounts for testing and verification.

**Triggers**:
- **Schedule**: Runs daily at 3:00 AM UTC for continuous validation
- **Manual**: Can be triggered manually via workflow_dispatch
- **On Changes**: Runs when workflow files or test data are modified

**What It Does**:
The workflow executes through 5 checkpoints to validate operations:

1. **Checkpoint 1: Initialize with Dummy Data**
   - Loads dummy service accounts and test scenarios
   - Validates JSON data structure
   - Confirms credentials are marked as dummy/testing only

2. **Checkpoint 2: Validate Service Accounts**
   - Validates service account permissions
   - Tests automation, deployment, and monitoring service accounts
   - Verifies permission models

3. **Checkpoint 3: Simulate Workflow Execution**
   - Simulates CI, caching, and deployment workflows
   - Tests cache functionality with dummy data
   - Validates workflow execution patterns

4. **Checkpoint 4: Validate Metrics**
   - Analyzes dummy performance metrics
   - Validates success rates and cache hit rates
   - Verifies repository data

5. **Checkpoint 5: Final Report**
   - Generates comprehensive checkpoint report
   - Summarizes all validation results
   - Confirms all operations completed successfully

**Test Data**:
- `test-data/dummy-service-accounts.json`: Simulated service accounts with permissions
- `test-data/dummy-workflow-data.json`: Test scenarios, metrics, and repository data

**Benefits**:
- ✅ Validates workflow operations without real credentials
- ✅ Simulates realistic scenarios for testing
- ✅ Provides checkpoint-based verification
- ✅ Ensures system reliability through continuous testing
- ✅ Safe testing environment with dummy data only
### 3. Workflow Run Notifications (`workflow-notifications.yml`)

**Purpose**: Automatically sends notifications when workflows complete.

**Triggers**:
- **Workflow Completion**: Any workflow in the repository
- **Workflow Requested**: When workflows start running

**What It Does**:
1. Detects workflow completion (success, failure, cancelled, skipped)
2. Extracts workflow details (name, status, branch, commit, user)
3. Sends notifications to configured channels:
   - 🔔 **Slack**: Rich formatted messages with action buttons
   - 📧 **Email**: Detailed email notifications
   - 💬 **GitHub Comments**: Automated comments on associated PRs
4. Provides job summary with notification status

**Benefits**:
- ✅ Instant notifications on workflow completion
- ✅ Multiple notification channels (Slack, Email, GitHub)
- ✅ Detailed context (status, branch, commit, user)
- ✅ Direct links to workflow runs
- ✅ Automatic PR comments for workflow results
- ✅ Configurable via repository variables

### 4. Pull Request Notifications (`pr-notifications.yml`)

**Purpose**: Automatically sends notifications when PRs are created or updated.

**Triggers**:
- **PR Opened**: When a new PR is created
- **PR Reopened**: When a closed PR is reopened
- **PR Synchronized**: When new commits are pushed to PR
- **PR Ready for Review**: When PR is marked ready for review
- **PR Closed**: When PR is closed or merged

**What It Does**:
1. Detects PR events with appropriate context
2. Extracts PR details (number, title, author, branches)
3. Sends notifications to configured channels:
   - 🔔 **Slack**: Rich formatted PR notifications
   - 📧 **Email**: Detailed email notifications
4. Provides job summary with notification status

**Benefits**:
- ✅ Instant notifications on PR events
- ✅ Track PR lifecycle (opened, updated, merged)
- ✅ Multiple notification channels
- ✅ Detailed PR context and metadata
- ✅ Direct links to pull requests
- ✅ Configurable via repository variables

### 5. Test Notifications (`test-notifications.yml`)

**Purpose**: Test workflow to verify notification system configuration.

**Triggers**:
- **Manual**: workflow_dispatch with configurable success/failure outcome

**What It Does**:
1. Runs a simple test job
2. Can simulate success or failure based on user input
3. Triggers the notification system
4. Helps verify notification configuration

**Benefits**:
- ✅ Easy way to test notification setup
- ✅ Verify Slack, email, and GitHub comment notifications
- ✅ No need to wait for real workflow events
- ✅ Configurable outcome for testing both success and failure scenarios

## Best Practices

### Using actions/cache@v4

The latest version of `actions/cache` includes:
- Improved performance and reliability
- Better cross-platform support
- Enhanced security features
- Support for GitHub's improved caching infrastructure

**Example Usage**:
```yaml
- name: Cache dependencies
  uses: actions/cache@v4
  with:
    path: |
      ~/.npm
      node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

### Why Update from v1/v2?

- **v1 and v2 are deprecated**: GitHub may remove support at any time
- **Security**: Newer versions include critical security patches
- **Performance**: v4 offers significant performance improvements
- **Features**: Access to latest caching features and improvements
- **Compatibility**: Ensures workflows work with current GitHub infrastructure

## Maintenance

The `auto-fix-deprecated-actions.yml` workflow handles most maintenance automatically. However, you can:

1. **Manual Trigger**: Run the workflow manually from the Actions tab
2. **Review PRs**: Check automated PRs for any workflow-specific considerations
3. **Add More Actions**: Extend the workflow to detect other deprecated actions

## Automated Notifications

The repository includes a comprehensive notification system for workflows and PRs. 

**📚 Documentation:**
- **[QUICKSTART.md](./QUICKSTART.md)** - Get started in 3 simple steps
- **[NOTIFICATIONS.md](./NOTIFICATIONS.md)** - Detailed setup and configuration guide

**Quick Start:**
1. Enable notification channels via repository variables:
   - `ENABLE_SLACK_NOTIFICATIONS=true`
   - `ENABLE_EMAIL_NOTIFICATIONS=true`
   - `ENABLE_GITHUB_COMMENTS=true`

2. Configure required secrets (see NOTIFICATIONS.md for details):
   - **Slack**: `SLACK_WEBHOOK_URL`
   - **Email**: `MAIL_SERVER`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_FROM`, `NOTIFICATION_EMAIL`
   - **GitHub**: No additional secrets needed (uses `GITHUB_TOKEN`)

3. Notifications work automatically once configured!

**Supported Notifications:**
- ✅ Workflow completion (success, failure, cancelled)
- ✅ PR created, updated, merged, or closed
- ✅ Slack rich messages with action buttons
- ✅ Email notifications with full details
- ✅ GitHub PR comments for workflow results

## Adding New Workflows

When creating new workflows:
1. Always use the latest stable versions of actions (e.g., `@v4`, `@v5`)
2. Use the `example-ci.yml` as a reference template
3. Test workflows in a feature branch before merging
4. The auto-fix workflow will catch any deprecated versions
5. New workflows will automatically trigger notifications when configured

## Troubleshooting

If the auto-fix workflow fails:
1. Check the workflow run logs in the Actions tab
2. Ensure the workflow has proper permissions (`contents: write`, `pull-requests: write`)
3. Verify no merge conflicts exist in workflow files
4. Check that the GitHub token has appropriate access

## Contributing

When contributing new workflows:
- Use latest action versions
- Include clear descriptions and comments
- Follow existing workflow patterns
- Test thoroughly before creating PRs
