# Notification Configuration Template

This file provides templates for configuring the automated notification system.

## Repository Variables

Set these in **Settings** → **Secrets and variables** → **Actions** → **Variables**:

```bash
# Enable/disable notification channels
ENABLE_SLACK_NOTIFICATIONS=true
ENABLE_EMAIL_NOTIFICATIONS=true
ENABLE_GITHUB_COMMENTS=true
```

## Repository Secrets

Set these in **Settings** → **Secrets and variables** → **Actions** → **Secrets**:

### Slack Configuration

```bash
# Slack webhook URL from https://api.slack.com/messaging/webhooks
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

### Email Configuration (Gmail Example)

```bash
# SMTP server configuration
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587

# Email credentials
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-gmail-app-password

# Email addresses
MAIL_FROM=notifications@yourdomain.com
NOTIFICATION_EMAIL=team@yourdomain.com
```

### Email Configuration (Outlook/Office365 Example)

```bash
# SMTP server configuration
MAIL_SERVER=smtp.office365.com
MAIL_PORT=587

# Email credentials
MAIL_USERNAME=your-email@outlook.com
MAIL_PASSWORD=your-outlook-password

# Email addresses
MAIL_FROM=notifications@yourdomain.com
NOTIFICATION_EMAIL=team@yourdomain.com
```

### Email Configuration (SendGrid Example)

```bash
# SMTP server configuration
MAIL_SERVER=smtp.sendgrid.net
MAIL_PORT=587

# Email credentials
MAIL_USERNAME=apikey
MAIL_PASSWORD=your-sendgrid-api-key

# Email addresses
MAIL_FROM=notifications@yourdomain.com
NOTIFICATION_EMAIL=team@yourdomain.com
```

## GitHub CLI Commands for Setup

Use these commands to set up configuration via GitHub CLI:

### Set Repository Variables

```bash
# Enable Slack notifications
gh variable set ENABLE_SLACK_NOTIFICATIONS --body "true"

# Enable email notifications
gh variable set ENABLE_EMAIL_NOTIFICATIONS --body "true"

# Enable GitHub PR comments
gh variable set ENABLE_GITHUB_COMMENTS --body "true"
```

### Set Repository Secrets

```bash
# Slack webhook
gh secret set SLACK_WEBHOOK_URL --body "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# Email configuration
gh secret set MAIL_SERVER --body "smtp.gmail.com"
gh secret set MAIL_PORT --body "587"
gh secret set MAIL_USERNAME --body "your-email@gmail.com"
gh secret set MAIL_PASSWORD --body "your-app-password"
gh secret set MAIL_FROM --body "notifications@yourdomain.com"
gh secret set NOTIFICATION_EMAIL --body "team@yourdomain.com"
```

## Testing Your Configuration

1. **Enable test mode first:**
   ```bash
   # Set only the channels you want to test
   gh variable set ENABLE_SLACK_NOTIFICATIONS --body "true"
   gh variable set ENABLE_EMAIL_NOTIFICATIONS --body "false"
   gh variable set ENABLE_GITHUB_COMMENTS --body "false"
   ```

2. **Run the test workflow:**
   - Go to **Actions** tab
   - Select "Test Notifications" workflow
   - Click "Run workflow"
   - Choose "success" or "failure" outcome
   - Click "Run workflow" button

3. **Verify notifications:**
   - Check your Slack channel (if enabled)
   - Check your email inbox (if enabled)
   - Check PR comments (if enabled and PR exists)

4. **Enable other channels:**
   Once one channel works, enable others and test again.

## Minimal Configuration

To get started quickly, you can enable just one notification channel:

### Option 1: GitHub Comments Only (No Secrets Required!)

```bash
gh variable set ENABLE_SLACK_NOTIFICATIONS --body "false"
gh variable set ENABLE_EMAIL_NOTIFICATIONS --body "false"
gh variable set ENABLE_GITHUB_COMMENTS --body "true"
```

This is the easiest option - no external services or secrets needed!

### Option 2: Slack Only

```bash
gh variable set ENABLE_SLACK_NOTIFICATIONS --body "true"
gh variable set ENABLE_EMAIL_NOTIFICATIONS --body "false"
gh variable set ENABLE_GITHUB_COMMENTS --body "false"

gh secret set SLACK_WEBHOOK_URL --body "YOUR_WEBHOOK_URL"
```

### Option 3: Email Only

```bash
gh variable set ENABLE_SLACK_NOTIFICATIONS --body "false"
gh variable set ENABLE_EMAIL_NOTIFICATIONS --body "true"
gh variable set ENABLE_GITHUB_COMMENTS --body "false"

gh secret set MAIL_SERVER --body "smtp.gmail.com"
gh secret set MAIL_PORT --body "587"
gh secret set MAIL_USERNAME --body "your-email@gmail.com"
gh secret set MAIL_PASSWORD --body "your-app-password"
gh secret set MAIL_FROM --body "notifications@yourdomain.com"
gh secret set NOTIFICATION_EMAIL --body "team@yourdomain.com"
```

## Verification Checklist

- [ ] Repository variables are set correctly
- [ ] Required secrets are configured for enabled channels
- [ ] Test workflow runs successfully
- [ ] Notifications received in configured channels
- [ ] No errors in workflow logs
- [ ] Notifications contain expected information
- [ ] Links in notifications work correctly

## Troubleshooting

### No notifications received

1. Check repository variables are set to `true`
2. Verify secrets are configured correctly
3. Check workflow run logs for errors
4. Test with the test-notifications workflow

### Slack notifications not working

1. Verify webhook URL is correct and active
2. Test webhook with curl:
   ```bash
   curl -X POST -H 'Content-type: application/json' \
     --data '{"text":"Test message"}' \
     YOUR_WEBHOOK_URL
   ```
3. Check Slack channel permissions

### Email notifications not working

1. Verify SMTP settings are correct
2. Check if 2FA is enabled (use app password)
3. Test SMTP connection separately
4. Check spam/junk folders
5. Verify email service allows SMTP access

### GitHub comments not appearing

1. Ensure PR exists for the branch
2. Check workflow has `pull-requests: write` permission
3. Verify `ENABLE_GITHUB_COMMENTS=true`
4. Check workflow logs for PR detection step

## Security Best Practices

- ✅ Never commit secrets to repository
- ✅ Use app-specific passwords for email services
- ✅ Rotate secrets regularly (every 90 days)
- ✅ Limit webhook URL exposure
- ✅ Use separate email accounts for notifications
- ✅ Monitor notification logs for anomalies
- ✅ Test in a private repository first
- ✅ Review permissions granted to workflows

## Advanced Configuration

### Multiple Slack Channels

Create multiple workflows with different webhook URLs for different channels:

```yaml
# In workflow file, override the webhook URL for specific conditions
- name: Send to alerts channel
  if: github.event.workflow_run.conclusion == 'failure'
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_ALERTS }}
```

### Email Distribution Lists

Set `NOTIFICATION_EMAIL` to a distribution list or multiple comma-separated emails.

### Conditional Notifications

Modify workflows to only notify on specific conditions:

```yaml
# Only notify on main branch
if: github.event.workflow_run.head_branch == 'main'

# Only notify on failures
if: github.event.workflow_run.conclusion == 'failure'

# Skip bot PRs
if: github.event.pull_request.user.login != 'dependabot[bot]'
```

## Support

For more help:
- See [NOTIFICATIONS.md](./NOTIFICATIONS.md) for detailed documentation
- See [QUICKSTART.md](./QUICKSTART.md) for quick setup guide
- Check workflow run logs in Actions tab
- Open an issue in the repository
