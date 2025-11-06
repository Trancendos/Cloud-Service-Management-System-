# AWS CodeBuild Configuration

This directory contains AWS CodeBuild buildspec configuration for the Cloud Service Management System.

## Overview

The `buildspec.yml` file provides equivalent functionality to the GitHub Actions workflow, including:
- Automated builds
- Dependency caching
- Node.js 20 runtime
- Build and test phases

## Setup Instructions

### 1. Prerequisites
- An AWS account
- AWS CodeBuild service access
- AWS CodePipeline (recommended for CI/CD automation)
- Source repository (GitHub, CodeCommit, Bitbucket, etc.)

### 2. Create CodeBuild Project

#### Using AWS Console:

1. Navigate to **AWS CodeBuild** → **Build projects** → **Create build project**
2. Configure project settings:
   - **Project name**: `cloud-service-management-build`
   - **Description**: Build project for Cloud Service Management System

3. **Source**:
   - **Source provider**: GitHub / AWS CodeCommit / Bitbucket
   - **Repository**: Select your repository
   - **Branch**: `main`

4. **Environment**:
   - **Environment image**: Managed image
   - **Operating system**: Ubuntu
   - **Runtime(s)**: Standard
   - **Image**: `aws/codebuild/standard:7.0` (includes Node.js 20)
   - **Image version**: Always use the latest
   - **Service role**: Create new or use existing

5. **Buildspec**:
   - **Build specifications**: Use a buildspec file
   - **Buildspec name**: `.aws/buildspec.yml`

6. **Artifacts** (optional):
   - **Type**: Amazon S3
   - **Bucket name**: Your S3 bucket
   - **Path**: `builds/`

7. **Logs**:
   - Enable CloudWatch Logs

8. Click **Create build project**

#### Using AWS CLI:

```bash
aws codebuild create-project \
  --name cloud-service-management-build \
  --source type=GITHUB,location=https://github.com/YOUR-USERNAME/Cloud-Service-Management-System-.git \
  --artifacts type=NO_ARTIFACTS \
  --environment type=LINUX_CONTAINER,image=aws/codebuild/standard:7.0,computeType=BUILD_GENERAL1_SMALL \
  --service-role arn:aws:iam::ACCOUNT_ID:role/CodeBuildServiceRole \
  --buildspec .aws/buildspec.yml
```

### 3. Configure Cache (Optional)

To enable caching for faster builds:

1. Create an S3 bucket for cache:
```bash
aws s3 mb s3://your-codebuild-cache-bucket
```

2. Update CodeBuild project to use caching:
```bash
aws codebuild update-project \
  --name cloud-service-management-build \
  --cache type=S3,location=your-codebuild-cache-bucket/cache
```

### 4. Set Up CodePipeline (Recommended)

Create a full CI/CD pipeline with CodePipeline:

1. Navigate to **AWS CodePipeline** → **Create pipeline**
2. **Pipeline settings**:
   - **Pipeline name**: `cloud-service-management-pipeline`
   - **Service role**: Create new or use existing

3. **Source stage**:
   - **Source provider**: GitHub / CodeCommit
   - **Repository**: Select your repository
   - **Branch**: `main`
   - **Change detection**: Amazon CloudWatch Events (webhook)

4. **Build stage**:
   - **Build provider**: AWS CodeBuild
   - **Project name**: Select your CodeBuild project

5. **Deploy stage**: Skip (or configure if needed)

6. Review and create

## Key Features

### Build Phases

The buildspec defines four phases:

1. **Install**: Install runtime and dependencies
```yaml
install:
  runtime-versions:
    nodejs: 20
```

2. **Pre-build**: Run before build (cache restoration)
```yaml
pre_build:
  commands:
    - echo "Pre-build phase"
```

3. **Build**: Main build commands
```yaml
build:
  commands:
    - echo "Build completed"
```

4. **Post-build**: Run after build (tests, deployments)
```yaml
post_build:
  commands:
    - echo "Running tests..."
```

### Caching

Cache npm dependencies for faster builds:
```yaml
cache:
  paths:
    - '/root/.npm/**/*'
    - 'node_modules/**/*'
```

## Customization

### Adding npm Build Scripts

```yaml
build:
  commands:
    - npm install
    - npm run build
    - npm test
```

### Environment Variables

#### In buildspec.yml:
```yaml
env:
  variables:
    NODE_ENV: "production"
    API_URL: "https://api.example.com"
```

#### In CodeBuild Console:
1. Go to your build project → **Edit** → **Environment**
2. **Additional configuration** → **Environment variables**
3. Add variables (can be marked as secrets)

#### Using AWS Systems Manager Parameter Store:
```yaml
env:
  parameter-store:
    DB_PASSWORD: /myapp/database/password
```

#### Using AWS Secrets Manager:
```yaml
env:
  secrets-manager:
    API_KEY: prod/api:key
```

### Artifacts

Output build artifacts to S3:
```yaml
artifacts:
  files:
    - '**/*'
  name: build-$CODEBUILD_BUILD_NUMBER
  base-directory: dist
```

### Reports

Generate test or code coverage reports:
```yaml
reports:
  test-results:
    files:
      - 'test-results/*.xml'
    file-format: 'JUNITXML'
  coverage-report:
    files:
      - 'coverage/clover.xml'
    file-format: 'CLOVERXML'
```

## Triggers

### GitHub Webhook
Automatically trigger builds on push:
1. In CodeBuild project settings
2. Enable **Webhook** for GitHub
3. Select events: **PUSH**, **PULL_REQUEST_CREATED**, **PULL_REQUEST_UPDATED**

### EventBridge Rule
Create scheduled builds:
```bash
aws events put-rule \
  --name codebuild-nightly \
  --schedule-expression "cron(0 2 * * ? *)" \
  --state ENABLED

aws events put-targets \
  --rule codebuild-nightly \
  --targets "Id"="1","Arn"="arn:aws:codebuild:region:account:project/cloud-service-management-build"
```

## IAM Permissions

CodeBuild service role needs these permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::your-cache-bucket/*"
    }
  ]
}
```

## Best Practices

1. **Use Cache**: Enable S3 caching for dependencies
2. **Right-size Compute**: Choose appropriate compute type (SMALL, MEDIUM, LARGE)
3. **Monitor Builds**: Use CloudWatch Logs and Metrics
4. **Secure Secrets**: Use Parameter Store or Secrets Manager
5. **Tag Resources**: Apply tags for cost tracking
6. **VPC Configuration**: Place CodeBuild in VPC if accessing private resources
7. **Timeout Settings**: Set appropriate build timeout (default: 60 minutes)

## Monitoring

### CloudWatch Logs
View real-time logs:
```bash
aws logs tail /aws/codebuild/cloud-service-management-build --follow
```

### Build Metrics
View build metrics in CloudWatch:
- Build duration
- Success rate
- Failed builds

## Troubleshooting

### Build Fails to Start
- Check IAM role permissions
- Verify buildspec.yml syntax
- Ensure source repository is accessible

### Cache Not Working
- Verify S3 bucket exists and is accessible
- Check cache paths in buildspec.yml
- Ensure IAM role has S3 permissions

### Timeout Issues
Increase build timeout:
```bash
aws codebuild update-project \
  --name cloud-service-management-build \
  --timeout-in-minutes 120
```

### Out of Memory
Increase compute resources:
```bash
aws codebuild update-project \
  --name cloud-service-management-build \
  --environment computeType=BUILD_GENERAL1_LARGE
```

## Cost Optimization

- Use caching to reduce build time
- Choose appropriate compute type
- Clean up old build artifacts
- Use build batches for parallel builds
- Set up automatic cleanup policies

## Resources

- [AWS CodeBuild Documentation](https://docs.aws.amazon.com/codebuild/)
- [Buildspec Reference](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html)
- [CodeBuild Samples](https://docs.aws.amazon.com/codebuild/latest/userguide/samples.html)
- [CodeBuild Pricing](https://aws.amazon.com/codebuild/pricing/)
