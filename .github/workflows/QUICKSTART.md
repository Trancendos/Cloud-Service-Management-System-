# Quick Start Guide - Automated Notifications

Get notifications for workflow runs and PRs in 3 simple steps!

## Step 1: Choose Your Notification Channels

Go to **Settings** → **Secrets and variables** → **Actions** → **Variables** tab

Create these variables (set to `true` or `false`):

```
ENABLE_SLACK_NOTIFICATIONS=true
ENABLE_EMAIL_NOTIFICATIONS=true
ENABLE_GITHUB_COMMENTS=true
```

## Step 2: Configure Secrets

### For Slack Notifications

1. Create a Slack Incoming Webhook:
   - Go to https://api.slack.com/messaging/webhooks
   - Click "Create your Slack app" or use existing app
   - Enable "Incoming Webhooks"
   - Add webhook to your channel
   - Copy the webhook URL

2. Add secret in GitHub:
   - Go to **Settings** → **Secrets and variables** → **Actions** → **Secrets** tab
   - Click **New repository secret**
   - Name: `SLACK_WEBHOOK_URL`
   - Value: Your webhook URL (starts with `https://hooks.slack.com/...`)

### For Email Notifications

Add these secrets (example for Gmail):

| Secret Name | Example Value |
|-------------|--------------|
| `MAIL_SERVER` | `smtp.gmail.com` |
| `MAIL_PORT` | `587` |
| `MAIL_USERNAME` | `your-email@gmail.com` |
| `MAIL_PASSWORD` | Your Gmail app password* |
| `MAIL_FROM` | `notifications@yourdomain.com` |
| `NOTIFICATION_EMAIL` | `team@yourdomain.com` |

*For Gmail, create an app password: [Google Account → Security → App Passwords](https://myaccount.google.com/apppasswords)

### For GitHub PR Comments

✅ **No secrets needed!** Just set `ENABLE_GITHUB_COMMENTS=true`

## Step 3: Done! 🎉

Notifications will automatically be sent when:
- ✅ Workflows complete (success, failure, cancelled)
- ✅ PRs are opened, updated, or merged
- ✅ Any workflow-related event occurs

## What You'll Get

### Slack Notifications
- Rich formatted messages with emojis
- Direct links to workflows and PRs
- Status indicators
- Action buttons

### Email Notifications
- Detailed email reports
- All context and metadata
- Direct links to GitHub

### GitHub Comments
- Automated comments on PRs
- Workflow results posted to PR
- Status indicators with emojis

## Testing Your Setup

1. Create a test PR or trigger a workflow
2. Check your configured notification channels
3. Verify you receive notifications

## Need Help?

See [NOTIFICATIONS.md](./NOTIFICATIONS.md) for:
- Detailed configuration instructions
- Troubleshooting tips
- Customization examples
- Advanced configuration

## Common SMTP Providers

| Provider | Server | Port |
|----------|--------|------|
| Gmail | smtp.gmail.com | 587 |
| Outlook | smtp.office365.com | 587 |
| SendGrid | smtp.sendgrid.net | 587 |
| Mailgun | smtp.mailgun.org | 587 |

## Security Notes

- ✅ Never commit secrets to your repository
- ✅ Use app-specific passwords for email
- ✅ Rotate secrets regularly
- ✅ Limit access to sensitive channels
