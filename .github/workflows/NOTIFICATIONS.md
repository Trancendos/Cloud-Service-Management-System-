# Automated Notifications Setup Guide

This guide explains how to configure and use the automated notification system for workflow runs and pull requests.

## Overview

The Cloud Service Management System includes automated notifications for:
- **Workflow Runs**: Get notified when workflows complete (success, failure, cancellation)
- **Pull Requests**: Get notified when PRs are opened, updated, ready for review, or merged

Notifications can be sent via:
- 🔔 **Slack**: Rich formatted messages with action buttons
- 📧 **Email**: Detailed email notifications
- 💬 **GitHub Comments**: Automated comments on PRs

## Features

### Workflow Run Notifications (`workflow-notifications.yml`)

Triggers on:
- Workflow completion (success, failure, cancelled, skipped)
- Any workflow in the repository

Provides:
- Status indicators with emojis
- Workflow name and result
- Branch and commit information
- Triggered by user details
- Direct link to workflow run
- Automatic PR comments when applicable

### Pull Request Notifications (`pr-notifications.yml`)

Triggers on:
- PR opened
- PR reopened
- PR synchronized (new commits pushed)
- PR ready for review
- PR closed/merged

Provides:
- PR number and title
- Action performed (opened, updated, merged, etc.)
- Author information
- Branch details
- Direct link to PR

## Configuration

### Step 1: Enable Notification Channels

Set repository variables to enable/disable notification channels:

1. Go to **Settings** → **Secrets and variables** → **Actions** → **Variables** tab
2. Create the following repository variables:

| Variable Name | Value | Description |
|---------------|-------|-------------|
| `ENABLE_SLACK_NOTIFICATIONS` | `true` or `false` | Enable/disable Slack notifications |
| `ENABLE_EMAIL_NOTIFICATIONS` | `true` or `false` | Enable/disable email notifications |
| `ENABLE_GITHUB_COMMENTS` | `true` or `false` | Enable/disable GitHub PR comments |

### Step 2: Configure Secrets

#### For Slack Notifications

1. Create a Slack webhook URL:
   - Go to your Slack workspace
   - Navigate to **Apps** → **Incoming Webhooks**
   - Click **Add to Slack** and select a channel
   - Copy the webhook URL

2. Add the secret to your repository:
   - Go to **Settings** → **Secrets and variables** → **Actions** → **Secrets** tab
   - Click **New repository secret**
   - Name: `SLACK_WEBHOOK_URL`
   - Value: Your Slack webhook URL

#### For Email Notifications

Add the following secrets to your repository:

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `MAIL_SERVER` | SMTP server address | `smtp.gmail.com` |
| `MAIL_PORT` | SMTP server port | `587` |
| `MAIL_USERNAME` | SMTP username | `your-email@gmail.com` |
| `MAIL_PASSWORD` | SMTP password or app password | `your-app-password` |
| `MAIL_FROM` | Sender email address | `notifications@yourdomain.com` |
| `NOTIFICATION_EMAIL` | Recipient email address | `team@yourdomain.com` |

**Gmail Setup Example:**
1. Enable 2-factor authentication on your Gmail account
2. Generate an App Password: [Google Account → Security → App Passwords](https://myaccount.google.com/apppasswords)
3. Use the app password as `MAIL_PASSWORD`

**Common SMTP Providers:**
- **Gmail**: `smtp.gmail.com:587`
- **Outlook/Office365**: `smtp.office365.com:587`
- **SendGrid**: `smtp.sendgrid.net:587`
- **Mailgun**: `smtp.mailgun.org:587`

#### For GitHub Comments

GitHub comments use the built-in `GITHUB_TOKEN` - no additional secrets needed! Just set `ENABLE_GITHUB_COMMENTS=true`.

### Step 3: Grant Permissions (Already Configured)

The workflows already have the necessary permissions configured:

**Workflow Notifications:**
```yaml
permissions:
  actions: read
  contents: read
  issues: write
  pull-requests: write
```

**PR Notifications:**
```yaml
permissions:
  contents: read
  pull-requests: read
```

## Usage

Once configured, the notifications work automatically:

### Automatic Workflow Notifications

Every time a workflow completes:
1. The notification system detects the completion
2. Extracts workflow details (name, status, branch, commit)
3. Sends notifications to enabled channels
4. If the workflow is related to a PR, adds a comment to that PR

### Automatic PR Notifications

Every time a PR event occurs:
1. The notification system detects the event
2. Extracts PR details (number, title, author, branches)
3. Sends notifications to enabled channels

## Notification Examples

### Slack Notification Example

**For Workflow Runs:**
```
✅ Workflow: Example CI with Cache

Status: success
Branch: feature/new-feature
Triggered by: username
Commit: abc1234

[View Workflow Run]
```

**For Pull Requests:**
```
🚀 Pull Request #42

Feature: Add new notification system

Action: opened
Author: username
Branch: feature/notifications → main
Commit: abc1234

[View Pull Request]
```

### Email Notification Example

**Subject:** `✅ Workflow 'Example CI with Cache' - success`

**Body:**
```
Workflow Run Notification

Workflow: Example CI with Cache
Status: success
Branch: feature/new-feature
Triggered by: username
Commit: abc1234

View the workflow run: https://github.com/...

Repository: owner/repo
```

### GitHub Comment Example

```markdown
✅ **Workflow Run Notification**

**Workflow:** Example CI with Cache
**Status:** success
**Commit:** abc1234

[View Workflow Run](https://github.com/...)
```

## Customization

### Adding New Workflows to Notification System

By default, notifications are configured for these workflows:
- Auto-fix Deprecated Actions
- Example CI with Cache
- Test Notifications

**To add notifications for new workflows:**

1. Edit `.github/workflows/workflow-notifications.yml`
2. Add your workflow name to the `workflows` list:

```yaml
on:
  workflow_run:
    workflows:
      - "Auto-fix Deprecated Actions"
      - "Example CI with Cache"
      - "Test Notifications"
      - "Your New Workflow Name"  # Add here
    types:
      - completed
```

**Note:** The notification workflow itself is NOT included in the list to prevent infinite notification loops.

### Customize Notification Conditions

Edit the workflow files to customize when notifications are sent:

**workflow-notifications.yml:**
```yaml
# Only notify on failures
if: github.event.workflow_run.conclusion == 'failure'

# Only notify on specific workflows (alternative to changing the workflows list)
if: github.event.workflow_run.name == 'CI/CD Pipeline'

# Only notify on main branch
if: github.event.workflow_run.head_branch == 'main'
```

**pr-notifications.yml:**
```yaml
# Only notify when PRs are opened
if: github.event.action == 'opened'

# Only notify for specific authors
if: github.event.pull_request.user.login != 'dependabot[bot]'
```

### Customize Notification Messages

Edit the notification steps in the workflow files to change message format:

**Slack:** Modify the `payload` section in the Slack notification step
**Email:** Modify the `body` section in the email notification step
**GitHub:** Modify the script in the GitHub comment step

### Add Custom Recipients

**Slack:** Configure different channels by creating multiple webhook URLs
**Email:** Change `NOTIFICATION_EMAIL` secret to a different address or distribution list
**GitHub:** Comments automatically go to the associated PR

## Troubleshooting

### Notifications Not Sending

1. **Check if notifications are enabled:**
   - Verify `ENABLE_*_NOTIFICATIONS` variables are set to `true`
   - Check the workflow run logs in the Actions tab

2. **Check secrets:**
   - Ensure all required secrets are set correctly
   - Test email SMTP settings separately
   - Verify Slack webhook URL is valid

3. **Check permissions:**
   - Workflows already have correct permissions configured
   - Ensure repository settings allow Actions workflows

### Slack Notifications Not Working

- Verify webhook URL is correct and active
- Check Slack channel permissions
- Test webhook URL with curl: 
  ```bash
  curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"Test message"}' \
    YOUR_WEBHOOK_URL
  ```

### Email Notifications Not Working

- Verify SMTP server and port
- Check if SMTP requires SSL/TLS (most use port 587 with STARTTLS)
- Ensure email account allows "less secure apps" or use app-specific password
- Check spam/junk folders

### GitHub Comments Not Appearing

- Only workflows triggered by PRs will get comments
- Check `ENABLE_GITHUB_COMMENTS` variable is set to `true`
- Verify workflow has `pull-requests: write` permission
- Ensure PR is still open

## Security Best Practices

1. **Never commit secrets** to the repository
2. **Use repository secrets** for sensitive data (webhook URLs, passwords)
3. **Use app-specific passwords** for email services
4. **Rotate secrets regularly**
5. **Limit webhook URL exposure** - don't share Slack webhooks publicly
6. **Use read-only tokens** when possible

## Advanced Configuration

### Conditional Notifications Based on Team

Add team-specific logic to notifications:

```yaml
- name: Determine notification recipients
  id: recipients
  run: |
    # Get list of changed files
    # Determine team based on files
    # Set team-specific Slack channel or email
```

### Integration with Other Tools

The notification workflows can be extended to integrate with:
- Microsoft Teams (similar to Slack)
- Discord (webhook-based)
- PagerDuty (for critical alerts)
- Jira (create issues on failures)
- Custom webhooks

### Notification Filtering

Create smart filters to reduce notification noise:

```yaml
# Skip notifications for bot PRs
if: github.event.pull_request.user.login != 'dependabot[bot]'

# Only notify on specific labels
if: contains(github.event.pull_request.labels.*.name, 'notify')

# Only notify during business hours (requires custom logic)
```

## Cost Considerations

These notification workflows run on GitHub Actions minutes:

- **Workflow notifications**: ~10-20 seconds per workflow run
- **PR notifications**: ~10-20 seconds per PR event
- **GitHub Free tier**: 2,000 minutes/month (enough for hundreds of notifications)
- **Public repositories**: Unlimited minutes

External service costs:
- **Slack**: Free for incoming webhooks
- **Email**: Free for most SMTP providers (within limits)
- **GitHub Comments**: Free (uses GitHub API)

## Support

If you encounter issues:
1. Check workflow run logs in the Actions tab
2. Review this documentation
3. Test individual notification channels
4. Open an issue in the repository

## Examples

See the `.github/workflows/` directory for:
- `workflow-notifications.yml` - Complete workflow notification setup
- `pr-notifications.yml` - Complete PR notification setup
- `example-ci.yml` - Example workflow that triggers notifications
