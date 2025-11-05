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

## Adding New Workflows

When creating new workflows:
1. Always use the latest stable versions of actions (e.g., `@v4`, `@v5`)
2. Use the `example-ci.yml` as a reference template
3. Test workflows in a feature branch before merging
4. The auto-fix workflow will catch any deprecated versions

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
