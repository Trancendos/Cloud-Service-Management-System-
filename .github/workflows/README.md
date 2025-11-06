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
