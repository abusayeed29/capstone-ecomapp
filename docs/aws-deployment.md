# AWS deployment with GitHub Actions

This repository now includes a GitHub Actions workflow at `.github/workflows/deploy-aws.yml` that deploys the app to AWS Elastic Beanstalk when code is pushed to `main` or when the workflow is run manually.

## What the workflow does

1. Installs PHP 8.2 and Node.js 22.
2. Creates a temporary CI `.env`, generates an app key, and runs the Laravel test suite.
3. Builds the Vite frontend assets.
4. Re-installs Composer dependencies without dev packages for deployment.
5. Deploys the repository to Elastic Beanstalk using GitHub OIDC and an AWS IAM role.

## AWS setup

Create an Elastic Beanstalk application and environment using the PHP platform.

Elastic Beanstalk needs the app served from `/public`, which is already configured in `.ebextensions/01_document_root.config`.

The post-deploy hook at `.platform/hooks/postdeploy/01_laravel.sh` will run:

- `php artisan storage:link --force`
- `php artisan migrate --force`
- `php artisan optimize:clear`
- `php artisan config:cache`
- `php artisan view:cache`

## GitHub repository configuration

Add this repository secret:

- `AWS_ROLE_TO_ASSUME`: the IAM role ARN that GitHub Actions will assume with OIDC.

Add these repository variables:

- `AWS_REGION`: your Elastic Beanstalk region, for example `us-east-1`
- `EB_APPLICATION_NAME`: your Elastic Beanstalk application name
- `EB_ENVIRONMENT_NAME`: your Elastic Beanstalk environment name

## Elastic Beanstalk environment variables

Set your production environment variables in the Elastic Beanstalk console, not in the repository.

Minimum recommended values:

- `APP_ENV=production`
- `APP_DEBUG=false`
- `APP_URL=https://your-domain.example`
- `APP_KEY=base64:...`
- `DB_CONNECTION=mysql`

If you attach an RDS instance through Elastic Beanstalk, this app now supports the Beanstalk-provided variables automatically for MySQL and MariaDB:

- `RDS_HOSTNAME`
- `RDS_PORT`
- `RDS_DB_NAME`
- `RDS_USERNAME`
- `RDS_PASSWORD`

If you use your own database instead, set the standard Laravel `DB_*` variables.

## First deploy checklist

1. Push the workflow to GitHub.
2. Create the IAM OIDC trust and deployment role in AWS.
3. Add the GitHub secret and variables.
4. Configure the Elastic Beanstalk environment variables.
5. Run the `Deploy to AWS Elastic Beanstalk` workflow or push to `main`.
