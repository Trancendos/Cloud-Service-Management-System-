# Cloud-Service-Management-System-
Management and deployment of GitHub services at 0 costs models

## Features

### 🔔 Automated Notifications
Get instant notifications for workflow runs and pull requests via:
- **Slack**: Rich formatted messages with action buttons
- **Email**: Detailed email notifications
- **GitHub Comments**: Automated PR comments for workflow results

### 🔧 Auto-fix Deprecated Actions
Automatically detect and update deprecated GitHub Actions to their latest versions.

### 📦 Example CI Workflows
Modern CI workflow templates using the latest GitHub Actions.

## Quick Start

### Enable Notifications

1. **Set repository variables** (Settings → Secrets and variables → Actions → Variables):
   ```
   ENABLE_SLACK_NOTIFICATIONS=true
   ENABLE_EMAIL_NOTIFICATIONS=true
   ENABLE_GITHUB_COMMENTS=true
   ```

2. **Configure secrets** for your notification channels:
   - **Slack**: Add `SLACK_WEBHOOK_URL`
   - **Email**: Add `MAIL_SERVER`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_FROM`, `NOTIFICATION_EMAIL`
   - **GitHub**: No additional secrets needed!

3. **Done!** Notifications work automatically.

See [.github/workflows/NOTIFICATIONS.md](.github/workflows/NOTIFICATIONS.md) for detailed setup instructions.

## Documentation

- [Workflows README](.github/workflows/README.md) - Overview of all workflows
- [Notifications Setup](.github/workflows/NOTIFICATIONS.md) - Complete notification configuration guide

## Workflows

- **workflow-notifications.yml** - Sends notifications when workflows complete
- **pr-notifications.yml** - Sends notifications for PR events
- **auto-fix-deprecated-actions.yml** - Automatically updates deprecated actions
- **example-ci.yml** - Template for modern CI workflows

## Contributing

Contributions are welcome! Please ensure:
- Use latest action versions
- Follow existing workflow patterns
- Test thoroughly before creating PRs
- Include clear documentation
