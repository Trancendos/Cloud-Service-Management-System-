# CircleCI Configuration

This directory contains CircleCI configuration for the Cloud Service Management System.

## Overview

The `config.yml` file provides equivalent functionality to the GitHub Actions workflow, including:
- Automated builds on push to main branch
- Pull request validation
- Dependency caching
- Node.js 20.x environment

## Setup Instructions

### 1. Prerequisites
- A CircleCI account (sign up at [circleci.com](https://circleci.com))
- Repository hosted on GitHub, Bitbucket, or GitLab

### 2. Connect Repository

1. Log in to [CircleCI](https://app.circleci.com/)
2. Click **Projects** in the sidebar
3. Find your repository in the list
4. Click **Set Up Project**
5. CircleCI will detect the config file at `.circleci/config.yml`
6. Click **Start Building**

### 3. Configure Context (Optional)

For shared environment variables across projects:
1. Go to **Organization Settings** → **Contexts**
2. Click **Create Context**
3. Add environment variables to the context
4. Reference in workflow:
```yaml
workflows:
  build-and-test-workflow:
    jobs:
      - build-and-test:
          context: my-context
```

### 4. Enable GitHub Checks (Recommended)

1. Go to project settings → **Advanced**
2. Enable **GitHub Status Updates**
3. Enable **Only build pull requests**

## Key Features

### Orbs

CircleCI Orbs are reusable configuration packages:
```yaml
orbs:
  node: circleci/node@5.1.0
```

Available Node.js orb commands:
- `node/install`: Install Node.js
- `node/install-packages`: Install npm/yarn packages with caching

### Executors

Define reusable execution environments:
```yaml
executors:
  node-executor:
    docker:
      - image: cimg/node:20.11
    working_directory: ~/project
```

### Caching

Cache npm dependencies for faster builds:
```yaml
- restore_cache:
    keys:
      - node-deps-v1-{{ .Branch }}-{{ checksum "package-lock.json" }}
      - node-deps-v1-{{ .Branch }}-
      - node-deps-v1-

- save_cache:
    key: node-deps-v1-{{ .Branch }}-{{ checksum "package-lock.json" }}
    paths:
      - ~/.npm
      - node_modules
```

### Workflows

Orchestrate jobs:
```yaml
workflows:
  version: 2
  build-and-test-workflow:
    jobs:
      - build-and-test:
          filters:
            branches:
              only:
                - main
                - /^pull\/.*$/
```

## Customization

### Adding Build Scripts

```yaml
- run:
    name: Build application
    command: npm run build
```

### Adding Tests with Coverage

```yaml
- run:
    name: Run tests
    command: npm test -- --coverage

- store_test_results:
    path: test-results

- store_artifacts:
    path: coverage
```

### Using Different Node.js Versions

#### Single Version
```yaml
executors:
  node-executor:
    docker:
      - image: cimg/node:18.19  # or 20.11, 22.0, etc.
```

#### Matrix Strategy (Multiple Versions)
```yaml
jobs:
  test:
    parameters:
      node-version:
        type: string
    docker:
      - image: cimg/node:<< parameters.node-version >>
    steps:
      - checkout
      - run: npm ci
      - run: npm test

workflows:
  test-multiple-versions:
    jobs:
      - test:
          matrix:
            parameters:
              node-version: ["18.19", "20.11", "22.0"]
```

### Environment Variables

#### In config.yml:
```yaml
jobs:
  build-and-test:
    environment:
      NODE_ENV: production
      API_URL: https://api.example.com
```

#### In CircleCI UI:
1. Go to **Project Settings** → **Environment Variables**
2. Click **Add Environment Variable**
3. Enter name and value

#### Using Contexts:
```yaml
workflows:
  build-and-test-workflow:
    jobs:
      - build-and-test:
          context:
            - my-shared-context
            - aws-credentials
```

### Docker Services

Add database or service containers:
```yaml
executors:
  node-postgres:
    docker:
      - image: cimg/node:20.11
      - image: cimg/postgres:14.0
        environment:
          POSTGRES_DB: testdb
          POSTGRES_USER: testuser
          POSTGRES_PASSWORD: testpass
```

## Advanced Features

### Workspaces

Share data between jobs:
```yaml
jobs:
  build:
    steps:
      - checkout
      - run: npm run build
      - persist_to_workspace:
          root: .
          paths:
            - dist/

  deploy:
    steps:
      - attach_workspace:
          at: .
      - run: ./deploy.sh
```

### Approval Jobs

Require manual approval before proceeding:
```yaml
workflows:
  build-deploy:
    jobs:
      - build
      - hold:
          type: approval
          requires:
            - build
      - deploy:
          requires:
            - hold
```

### Scheduled Workflows

Run workflows on a schedule:
```yaml
workflows:
  nightly:
    triggers:
      - schedule:
          cron: "0 2 * * *"  # 2 AM daily
          filters:
            branches:
              only:
                - main
    jobs:
      - test
```

### Resource Classes

Choose compute resources:
```yaml
jobs:
  build:
    resource_class: medium  # small, medium, large, xlarge
    docker:
      - image: cimg/node:20.11
```

Available resource classes (varies by plan):
- **Free**: `small`, `medium`
- **Paid**: `medium+`, `large`, `xlarge`, `2xlarge`, `2xlarge+`

### Parallelism

Run tests in parallel:
```yaml
jobs:
  test:
    parallelism: 4
    steps:
      - checkout
      - run: npm ci
      - run:
          command: |
            TEST_FILES=$(circleci tests glob "test/**/*.test.js" | circleci tests split --split-by=timings)
            npm test $TEST_FILES
```

## Best Practices

1. **Use Orbs**: Leverage official orbs for common tasks
2. **Cache Aggressively**: Cache dependencies and build outputs
3. **Optimize Docker Images**: Use CircleCI convenience images (`cimg/*`)
4. **Split Tests**: Use parallelism for large test suites
5. **Store Artifacts**: Keep test results and coverage reports
6. **Use Contexts**: Share environment variables across projects
7. **Monitor Credits**: Track usage to optimize costs

## Monitoring & Debugging

### View Pipeline Insights
- Go to **Pipelines** → Select a pipeline
- View timing, success rate, and duration trends

### SSH into Build
Add SSH key and then:
```yaml
- run:
    name: Wait for SSH
    command: sleep 3600
    when: on_fail
```
Then click **Rerun job with SSH** in the UI.

### Enable Debug Mode
Set environment variable:
```
CIRCLECI_DEBUG=true
```

## Troubleshooting

### Cache Not Restoring
- Verify cache key matches save key
- Check that `package-lock.json` exists
- Try clearing cache: Project Settings → Advanced → Clear Cache

### Out of Memory
- Increase resource class
- Reduce parallelism
- Optimize build process

### Checkout Fails
- Verify repository access
- Check deploy keys in project settings
- Ensure branch exists

### Docker Rate Limits
Use CircleCI convenience images or authenticate:
```yaml
- run:
    name: Docker login
    command: echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
```

## Cost Optimization

CircleCI pricing is based on credits:
- Free tier: 2,500 credits/week
- Credits vary by resource class

Optimization tips:
- Use appropriate resource classes
- Enable caching
- Optimize test suites
- Use workflows to skip unnecessary jobs
- Monitor credit usage in insights

## Resources

- [CircleCI Documentation](https://circleci.com/docs/)
- [Configuration Reference](https://circleci.com/docs/configuration-reference/)
- [Orbs Registry](https://circleci.com/developer/orbs)
- [CircleCI Blog](https://circleci.com/blog/)
- [Pricing](https://circleci.com/pricing/)

## Support

- [CircleCI Discuss Forum](https://discuss.circleci.com/)
- [CircleCI Support](https://support.circleci.com/)
- [Status Page](https://status.circleci.com/)
